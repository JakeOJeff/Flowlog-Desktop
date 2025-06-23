local Scenery = {
    __NAME = "Scenery";
    __VERSION = "0.4";
    __DESCRIPTION = "Scenery - A dead simple Love2D SceneManager";
    __LICENSE = [[
        MIT License

        Copyright (c) 2024 Paltze and Contributors

        Permission is hereby granted, free of charge, to any person obtaining a copy
        of this software and associated documentation files (the "Software"), to deal
        in the Software without restriction, including without limitation the rights
        to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
        copies of the Software, and to permit persons to whom the Software is
        furnished to do so, subject to the following conditions:

        The above copyright notice and this permission notice shall be included in all
        copies or substantial portions of the Software.

        THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
        IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
        FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
        AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
        LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
        OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
        SOFTWARE.
    ]]
}

-- Split file into name and extension

local split = function(inputstr, sep)
    local t = {}
    for res in string.gmatch(inputstr, "([^" ..sep.."]+)") do table.insert(t, res) end
    return t[1], t[#t]
end

-- Automatically load scenes from the given directory

local autoLoad = function(directory)
    -- Get the files in the directory
    local files = love.filesystem.getDirectoryItems(directory)
    local scenes = {}

    for _, value in ipairs(files) do
        local file, ext = split(value, ".")

        -- Require scene
        if ext == file then
            local info = love.filesystem.getInfo(directory .. "/" .. file)

            -- Check if item is a directory
            if info and (info.type == "directory" or info.type == "symlink") then

                info = love.filesystem.getInfo(directory .. "/" .. file .. "/init.lua")

                -- Check for the init file
                
                if info and info.type == "file" then
                    scnes[file] = require(directory .. "." .. file)
                end
            end
        elseif ext == "lua" and file ~= "conf" and file ~= "main" then
            scenes[file] = require(directory .. "." .. file)
        end

    end

    return scenes
end
