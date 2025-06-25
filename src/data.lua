local data = {}

-- Require Data
json = require "src.libraries.json"
fileData = love.filesystem.read("data.txt")
fileStatusText = ""
if not fileData then
    fileStatusText = "ERROR RECEIVING DATA : PLEASE RECHECK IF YOU'VE COPIED DATA CORRECTLY"
elseif fileData ~= nil then
    fileStatusText = "RECEIVED DATA : CHECKING FORMAT"
    print(fileData)
   -- data = json.decode(fileData)
end

function data:draw()

    love.graphics.print(fileStatusText)

end

return data



