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

function data:load()
    for i = 1, 3 do
        elements.menuButtons[i].callback = function() currentTab = i end
    end
end

function data:draw()
    if not isDataValid then
        love.graphics.print(fileStatusText)
    else
        for i = 1, 3 do elements.menuButtons[i]:draw() end
        lg.setColor(hexToRGB("#906c4e"))

        if currentTab == 1 then drawMoodData() end
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
function formatDateTime(iso)
    local year, month, day, hour, min, sec = iso:match("(%d+)-(%d+)-(%d+)T(%d+):(%d+):?(%d*)")
    local t = os.time({
        year = tonumber(year),
        month = tonumber(month),
        day = tonumber(day),
        hour = tonumber(hour),
        min = tonumber(min),
        sec = sec ~= "" and tonumber(sec) or 0
    })
    return os.date("%A, %d %B %Y - %I:%M %p", t)
end

function drawMoodData()
    local padding = 20
    local tagMargin = 6
    local tagHeight = 30
    local tagPaddingX = 12

    local moodIcons = {
        happy = "😄", sad = "😢", angry = "😡", tired = "😴",
        anxious = "😰", excited = "🤩", bored = "😐",
        stressed = "😖", peaceful = "🧘", lonely = "🥺"
    }

  local moodColors = {
    happy     = {0.89, 0.65, 0.42},    -- fawn
    sad       = {0.925, 0.808, 0.654}, -- sunset
    angry     = {0.447, 0.235, 0.129}, -- kobicha
    tired     = {0.925, 0.808, 0.654}, -- sunset
    anxious   = {0.565, 0.424, 0.306}, -- raw umber
    excited   = {0.89, 0.65, 0.42},    -- fawn
    bored     = {0.565, 0.424, 0.306}, -- raw umber
    stressed  = {0.447, 0.235, 0.129}, -- kobicha
    peaceful  = {0.996, 0.886, 0.737}, -- navajo white
    lonely    = {0.573, 0.463, 0.369}  -- raw umber hover
}


    local moodSuggestions = {
        happy = "You're doing great! Keep that energy flowing 🎉",
        sad = "It’s okay to feel down. Consider journaling or a short walk 💙",
        angry = "Take a deep breath. Try releasing tension through movement 🔥",
        tired = "Maybe a quick nap or some water would help 😴",
        anxious = "Slow breaths. You're safe and capable of handling this 💆",
        excited = "Awesome! Use that momentum to create something new 🚀",
        bored = "Try a new challenge or hobby to spark curiosity 🎨",
        stressed = "Take 5 mins off. A calm mind handles more 🧘",
        peaceful = "Stay grounded and enjoy the moment 🌿",
        lonely = "Reach out to someone. Connection helps 🤝"
    }

    local mood = DATA.mood.currentMood
    local moodColor = moodColors[mood] or {1, 1, 1}
    local moodIcon = moodIcons[mood] or "💬"
    local suggestion = moodSuggestions[mood] or "You're doing your best, and that's enough."

    -- Mood Header
    lg.setFont(hhfontb)
    lg.setColor(1, 1, 1)
    lg.print("Mood", wW/2 - hhfontb:getWidth("Mood")/2, 75)

    lg.setFont(hfont)
    local timeWelcomeMessage = getTimeOfDay() .. "! Hope you are doing well."
    lg.print(timeWelcomeMessage, wW/2 - hfont:getWidth(timeWelcomeMessage)/2, 100)

    -- Mood Box
    local y = 150
    local boxWidth, boxHeight = 400, 150
    local boxX = wW/2 - boxWidth/2

    -- Shadow
    lg.setColor(0, 0, 0, 0.2)
    lg.rectangle("fill", boxX + 4, y + 4, boxWidth, boxHeight, 12, 12)

    -- Colored Box
    lg.setColor(moodColor[1], moodColor[2], moodColor[3], 0.3)
    lg.rectangle("fill", boxX, y, boxWidth, boxHeight, 12, 12)
    lg.setColor(moodColor)
    lg.rectangle("line", boxX, y, boxWidth, boxHeight, 12, 12)

    lg.setColor(1, 1, 1)
    lg.print(moodIcon .. " Current Mood: " .. mood, wW/2 - hfont:getWidth("Current Mood: " .. mood)/2, y + 10)
    lg.print("Intensity: " .. DATA.mood.intensity, wW/2 - hfont:getWidth("Intensity: " .. DATA.mood.intensity)/2, y + 40)
    lg.print("Notes: " .. DATA.mood.notes, wW/2 - hfont:getWidth("Notes: " .. DATA.mood.notes)/2, y + 70)

    -- Time
    local formattedDate = formatDateTime(DATA.mood.timestamp)
    lg.print("🕒 " .. formattedDate, wW/2 - hfont:getWidth(formattedDate)/2, y + 100)

    -- Tags
    y = y + 180
    lg.setFont(hfont)
    lg.print("🏷️ Tags:", wW/2 - hfont:getWidth("🏷️ Tags:")/2, y)

    y = y + 30
    local tagY = y
    local tags = DATA.mood.tags

    -- Word wrapping
    local tagLines = {}
    local line = {}
    local lineWidth = 0
    local maxLineWidth = wW - 2 * padding

    for i, tag in ipairs(tags) do
        local tagWidth = hfont:getWidth(tag) + 2 * tagPaddingX + tagMargin
        if lineWidth + tagWidth > maxLineWidth and #line > 0 then
            table.insert(tagLines, line)
            line = {}
            lineWidth = 0
        end
        table.insert(line, tag)
        lineWidth = lineWidth + tagWidth
    end
    if #line > 0 then table.insert(tagLines, line) end

    -- Draw each line
    for _, tagLine in ipairs(tagLines) do
        local totalLineWidth = 0
        for _, tag in ipairs(tagLine) do
            totalLineWidth = totalLineWidth + hfont:getWidth(tag) + 2 * tagPaddingX + tagMargin
        end
        totalLineWidth = totalLineWidth - tagMargin

        local tagX = wW/2 - totalLineWidth / 2

        for _, tag in ipairs(tagLine) do
            local tagWidth = hfont:getWidth(tag) + 2 * tagPaddingX

            -- Tag Shadow
            lg.setColor(0, 0, 0, 0.2)
            lg.rectangle("fill", tagX + 2, tagY + 2, tagWidth, tagHeight, 8, 8)

            -- Tag Background
            lg.setColor(moodColor[1], moodColor[2], moodColor[3], 0.25)
            lg.rectangle("fill", tagX, tagY, tagWidth, tagHeight, 8, 8)

            -- Border
            lg.setColor(moodColor)
            lg.rectangle("line", tagX, tagY, tagWidth, tagHeight, 8, 8)

            -- Tag Text
            lg.setColor(1, 1, 1)
            lg.print(tag, tagX + tagPaddingX, tagY + tagHeight/2 - hfont:getHeight()/2)

            tagX = tagX + tagWidth + tagMargin
        end
        tagY = tagY + tagHeight + tagMargin
    end

    -- Suggestion
    lg.setFont(sfont or hfont)
    local tipY = tagY + 20
    lg.setColor(1, 1, 1)
    lg.printf("💡 Tip: " .. suggestion, padding, tipY, wW - 2 * padding, "center")
end



return data
