local data = {}

-- Require Data
json = require "src.libraries.json"
receivedData = love.filesystem.read("data.txt")
fileData = json.decode(receivedData)
isDataValid = false
fileStatusText = ""
if not receivedData then
    fileStatusText = "NO DATA RECEIVED"
elseif checkDataValidity(fileData) == "invalid" then
    fileStatusText = "ERROR RECEIVING DATA : PLEASE RECHECK IF YOU'VE COPIED DATA CORRECTLY"
    print(receivedData)
   -- data = json.decode(fileData)
elseif receivedData and checkDataValidity(fileData) == "valid" then
    isDataValid = true
end

tabs = {
    "mood",
    "tasks",
    "log"
}
currentTab = 1

function data:draw()
    if not isDataValid then
        love.graphics.print(fileStatusText)
    else
        
        
        if currentTab == 1 then
            lg.setFont(hhfontb)
            lg.print("Mood")
            
            lg.setFont(hhfont)
            lg.print(getTimeOfDay()", Hope you are doing well.")
            
            lg.setFont(hfont)
            lg.print("Current Mood")
        end
    end

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
