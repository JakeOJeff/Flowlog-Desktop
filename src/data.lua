local data = {}

-- Library Initialization
button = require 'src.libraries.button'
graphing = require 'src.libraries.graphing'
json = require "src.libraries.json"
-- CLASS OOP INITIALIZATION -- 
elements = require 'src.datalists.elements'
-- Import tabs
require 'src.data-tabs.mood'
require 'src.data-tabs.tasks'
require 'src.data-tabs.logs'


-- Find image 
local streakImage = love.graphics.newImage("assets/imgs/streak.png")

isDataValid = false
fileStatusText = ""
tabs = {"mood", "tasks", "log"}
currentTab = 1
DATA = {}

-- Load Data | Add and load button callbacks
function data:load()
    -- receive Data
local receivedData = love.filesystem.read("data.txt")


-- Check if data has received ( Find applicable information and send out corresponding error messages )
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
    for i = 1, 3 do
        elements.menuButtons[i].callback = function() currentTab = i end
    end
    elements.refreshButton.callback = function() data.setScene("home") end
    elements.exitButton.callback = function() love.event.quit() end
end

-- Update data | Mainly 
function data:update(dt)
    elements.refreshButton:update(dt)
    elements.exitButton:update(dt)
    for i = 1, 3 do elements.menuButtons[i]:update(dt) end
end

function data:draw()
    -- Only display tab and tab options only if Data is Valid
    if not isDataValid then
        love.graphics.print(fileStatusText)
    else
        -- Draw all required Button
        elements.exitButton:draw()
        elements.refreshButton:draw()
        for i = 1, 3 do elements.menuButtons[i]:draw() end

        -- Tab Display
        if currentTab == 1 then
            drawMoodData()
        elseif currentTab == 2 then
            drawTasksData()
        elseif currentTab == 3 then
            drawLogdata()
        end

        -- Display Streaks
        -- SHADOW
        lg.setColor(0, 0, 0, 0.1)
        lg.draw(streakImage, 50, wW - 80 + 3, 0, 50 / streakImage:getWidth(),
                50 / streakImage:getHeight())

        -- Streak Image
        lg.setColor(1, 1, 1)
        lg.draw(streakImage, 50, wW - 80, 0, 50 / streakImage:getWidth(),
                50 / streakImage:getHeight())

        -- Streak Number 
        lg.setFont(hhfontb)
        lg.setColor(0, 0, 0, 0.2)
        -- lg.print("10", 100 + 3, wW - 60 + 3 )
        lg.setColor(pals.lightAccent)
        lg.print(DATA.streak, 100, wW - 60)
    end

end

function data:mousepressed(x, y, button)
    elements.refreshButton:mousepressed(x, y, button)
    elements.exitButton:mousepressed(x, y, button)
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
-- Convert ISO timestamp to formatted date string
function formatDateTime(iso)
    local year, month, day, hour, min, sec = iso:match(
                                                 "(%d+)-(%d+)-(%d+)T(%d+):(%d+):?(%d*)")
    local t = os.time({
        year = tonumber(year),
        month = tonumber(month),
        day = tonumber(day),
        hour = tonumber(hour),
        min = tonumber(min),
        sec = tonumber(sec) ~= "" and tonumber(sec) or 0
    })
    return os.date("%A, %d %B %Y - %I:%M %p", t)
end




function daysBeforeThisDay(date, no)
    local y = tonumber(string.sub(date,1, 4))
    local m = tonumber(string.sub(date,6, 7))
    local d = tonumber(string.sub(date,9, 10))
    local num = no
    local function getMonthDays(month, year)
        if month == 2 then
            if (year % 4 == 0 and year % 100 ~= 0) or (year % 400 == 0) then
                return 29
            else
                return 28
            end
        elseif month == 4 or month == 6 or month == 9 or month == 11 then 
            return 30
        else
            return 31
        end
    end
    local ye, mo, da = y, m, d
    for i = 2, num do
        da = da - 1
        if da < 1 then
            mo = mo - 1
            if mo < 1 then
                mo = 12
                ye = ye - 1
            end
            da = getMonthDays(mo, ye)
        end
    end

    return string.format("%04d-%02d-%02d", ye, mo, da)

end

return data
