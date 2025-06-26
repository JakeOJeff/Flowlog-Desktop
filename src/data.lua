local data = {}

-- CLASS OOP INITIALIZATION -- 
local elements = require 'src.datalists.elements'
-- Require Data
json = require "src.libraries.json"
local receivedData = love.filesystem.read("data.txt")
isDataValid = false
fileStatusText = ""
DATA = {}

if receivedData then
    DATA, _, err = json.decode(receivedData)
    if DATA then
        print("Success!", DATA.mood.currentMood)
        isDataValid = true
    else
        print("JSON decode error:", err)
        fileStatusText =
            "ERROR RECEIVING DATA : PLEASE RECHECK IF YOU'VE COPIED DATA CORRECTLY"
    end
else
    print("Failed to read data.txt")
    fileStatusText = "NO DATA RECEIVED"
end

tabs = {"mood", "tasks", "log"}
currentTab = 1

function data:draw()
    if not isDataValid then
        love.graphics.print(fileStatusText)
    else
        for i = 1, 3 do elements.menuButtons[i]:draw() end
        lg.setColor(hexToRGB("#6a381f"))

        if currentTab == 1 then
            lg.setFont(hhfontb)
            lg.print("Mood", 0, 60)

            lg.setFont(hhfont)
            lg.print(getTimeOfDay() .. "! Hope you are doing well.", 0, 85)

            lg.setFont(hfont)
            lg.print("Current Mood " .. DATA.mood.currentMood, 0, 110)
        end
    end

end

function data:update(dt) for i = 1, 3 do elements.menuButtons[i]:update(dt) end end

function data:mousepressed(x, y, button)
    for i = 1, 3 do elements.menuButtons[i]:mousepressed(x, y, button) end
end

function checkDataValidity(dataTable)
    if dataTable.mood and dataTable.tasks and dataTable.mood then
        return "valid"
    else
        return "invalid"
    end
end

function getTimeOfDay()
    local hour = tonumber(os.date("%H")) -- gets the hour in 24-hour format

    if hour >= 5 and hour < 12 then
        return "Morning"
    elseif hour >= 12 and hour < 17 then
        return "Afternoon"
    elseif hour >= 17 and hour < 20 then
        return "Evening"
    else
        return "Night"
    end
end

return data
