local data = {}

-- Library Initialization
button = require 'src.libraries.button'
graphing = require 'src.libraries.graphing'
json = require "src.libraries.json"

-- CLASS OOP INITIALIZATION -- 
local elements = require 'src.datalists.elements'

-- Find image 
local streakImage = love.graphics.newImage("assets/imgs/streak.png")

-- receive Data
local receivedData = love.filesystem.read("data.txt")
isDataValid = false
fileStatusText = ""
tabs = {"mood", "tasks", "log"}
currentTab = 1
DATA = {}

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

-- Load Data | Add and load button callbacks
function data:load()
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

function drawMoodData()
    local padding = 20
    local tagMargin = 6
    local tagHeight = 30
    local tagPaddingX = 12

    -- local moodColors = {
    --     happy = {0.984, 0.753, 0.498}, -- #fbc080 (warm pastel orange)
    --     sad = {0.867, 0.659, 0.682}, -- #dd9faa (soft mauve)
    --     angry = {0.745, 0.373, 0.353}, -- #be5f5a (deep rose red)
    --     tired = {0.875, 0.753, 0.702}, -- #dfc0b3 (pale beige-pink)
    --     anxious = {0.729, 0.553, 0.486}, -- #ba8d7c (soft earthy brown)
    --     excited = {0.988, 0.616, 0.459}, -- #fc9d75 (vivid peach)
    --     bored = {0.729, 0.639, 0.561}, -- #baa390 (dusty taupe)
    --     stressed = {0.667, 0.298, 0.267}, -- #aa4c44 (muted rust red)
    --     peaceful = {0.988, 0.875, 0.820}, -- #fcdfd1 (creamy light peach)
    --     lonely = {0.714, 0.557, 0.533} -- #b68e88 (warm muted rose)
    -- }

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
    -- local moodColor = moodColors[mood] or {hexToRGB("#906c4e")}
    local suggestion = moodSuggestions[mood] or
                           "You're doing your best, and that's enough."

    -- Mood Header
    lg.setFont(hhfontb)
    lg.setColor(pals.headingColor)
    lg.print("Mood", wW / 2 - hhfontb:getWidth("Mood") / 2, 75)

    lg.setFont(hfont)
    local timeWelcomeMessage = getTimeOfDay() .. "! Hope you are doing well."
    lg.print(timeWelcomeMessage,
             wW / 2 - hfont:getWidth(timeWelcomeMessage) / 2, 105)

    -- Mood Box
    local y = 150
    local boxWidth, boxHeight = 600, 220
    local boxX = wW / 2 - boxWidth / 2

    -- -- Shadow
    -- lg.setColor(0, 0, 0, 0.2)
    -- lg.rectangle("fill", boxX + 4, y + 4, boxWidth, boxHeight, 12, 12)

    -- -- Colored Box
    -- lg.setColor(pals.lightAccent[1], pals.lightAccent[2], pals.lightAccent[3], 0.3)
    -- lg.rectangle("fill", boxX, y, boxWidth, boxHeight, 12, 12)
    -- lg.setColor(pals.lightAccent)
    -- lg.rectangle("line", boxX, y, boxWidth, boxHeight, 12, 12)

    -- Main Taskbox Shadow 
    lg.setColor(0, 0, 0, 0.2)
    lg.rectangle("fill", boxX + 4, y + 4, boxWidth, boxHeight, 12, 12)

    -- Colored box 
    lg.setColor(pals.lightAccent)
    lg.rectangle("fill", boxX, y, boxWidth, boxHeight, 12, 12)
    lg.setColor(pals.lightAccentBorder)
    lg.rectangle("line", boxX, y, boxWidth, boxHeight, 12, 12)

    -- lg.setColor(1,1,1)
    -- lg.print("Current Mood: " .. mood,
    --          wW / 2 - hfont:getWidth("Current Mood: " .. mood) / 2, y + 15)
    -- lg.print("Mood Intensity: " .. DATA.mood.intensity,
    --          wW / 2 - hfont:getWidth("Mood Intensity: " .. DATA.mood.intensity) / 2,
    --          y + 45)
    -- lg.print("Notes: " .. DATA.mood.notes,
    --          wW / 2 - hfont:getWidth("Notes: " .. DATA.mood.notes) / 2, y + 75)

    -- -- Time
    -- local formattedDate = formatDateTime(DATA.mood.timestamp)
    -- lg.print(formattedDate, wW / 2 - hfont:getWidth(formattedDate) / 2, y + 105)

    elements.pichart:draw()

    -- Tags
    y = y + boxHeight + 10
    lg.setFont(tagfont)
    lg.setColor(pals.textColor)
    lg.print("Tags:", wW / 2 - hfont:getWidth("Tags:") / 2, y)

    y = y + 30
    local tagY = y
    local tags = DATA.mood.tags

    -- Word wrapping
    local tagLines = {}
    local line = {}
    local lineWidth = 0
    local maxLineWidth = wW - 2 * padding

    for i, tag in ipairs(tags) do
        local tagWidth = tagfont:getWidth(tag) + 2 * tagPaddingX + tagMargin
        if lineWidth + tagWidth > maxLineWidth and #line > 0 then
            table.insert(tagLines, line)
            line = {}
            lineWidth = 0
        end
        table.insert(line, tag)
        lineWidth = lineWidth + tagWidth
    end
    if #line > 0 then table.insert(tagLines, line) end

    local tagTextColor = {1, 1, 1}

    -- Draw each line
    for _, tagLine in ipairs(tagLines) do
        local totalLineWidth = 0
        for _, tag in ipairs(tagLine) do
            totalLineWidth = totalLineWidth + tagfont:getWidth(tag) + 2 *
                                 tagPaddingX + tagMargin
        end
        totalLineWidth = totalLineWidth - tagMargin

        local tagX = wW / 2 - totalLineWidth / 2

        for _, tag in ipairs(tagLine) do
            local tagWidth = tagfont:getWidth(tag) + 2 * tagPaddingX

            -- Tag Shadow
            lg.setColor(0, 0, 0, 0.2)
            lg.rectangle("fill", tagX + 2, tagY + 2, tagWidth, tagHeight, 8, 8)

            -- Tag Background
            lg.setColor(pals.lightAccent)
            lg.rectangle("fill", tagX, tagY, tagWidth, tagHeight, 8, 8)

            -- Border
            lg.setColor(pals.lightAccentBorder)
            lg.rectangle("line", tagX, tagY, tagWidth, tagHeight, 8, 8)

            -- Tag Text
            local mx, my = love.mouse:getPosition()
            lg.setFont(tagfont)

            if mx > tagX and mx < tagX + tagWidth and my > tagY and my < tagY +
                tagHeight then
                lg.setColor(pals.textColor)
                if love.mouse.isDown(1) then
                    love.system.setClipboardText(tag)
                    lg.setColor(pals.headingColor)
                end
            else
                lg.setColor(hexToRGB("#ffffff"))
            end

            lg.print(tag, tagX + tagPaddingX,
                     tagY + tagHeight / 2 - tagfont:getHeight() / 2)

            tagX = tagX + tagWidth + tagMargin
        end
        tagY = tagY + tagHeight + tagMargin
    end

    -- Suggestion
    lg.setFont(hfont)
    local tipY = tagY + 20
    lg.setColor(pals.textColor)

    lg.printf("Tip: " .. suggestion, padding, tipY, wW - 2 * padding, "center")
end

function drawTasksData()
    local padding = 20

    local motivationMessages = {
        "You've been doing so well so far",
        "Proud of you how far you've come along.",
        "Take a break and relax whenever you need to.",
        "Don't forget to rest every once in a while!",
        "If you ever feel down or burnt out, don't forget to take a rest!",
        "Don't feel ashamed to take a rest if you are exhausted",
        "Proud of the progress you've accomplished so far!"
    }

    local taskDoneMessages = {
        "You have so much potential today!", "You are doing so good so far.",
        "You are doing so well!", "You have been brilliant today!",
        "You have had exceptional motivation today!",
        "At this pace, you are having exceptional self-growth!",
        "It is insanely inspiring how committed you are to this!",
        "You are unstoppable today!"
    }
    local doneTasksToday = 30

    -- Pick a random motivational message
    local tasksDescriptionMessage = taskDoneMessages[math.floor(doneTasksToday /
                                                                    10)] or
                                        taskDoneMessages[#taskDoneMessages]

    -- Task Header
    lg.setFont(hhfontb)
    lg.setColor(pals.headingColor)
    lg.print("Tasks", wW / 2 - hhfontb:getWidth("Tasks") / 2, 75)

    lg.setFont(hfont)
    lg.print(tasksDescriptionMessage,
             wW / 2 - hfont:getWidth(tasksDescriptionMessage) / 2, 105)

    -- Main TaskBox
    local y = 150
    local mainBoxWidth, mainBoxHeight = 600, 450
    local mainBoxX = wW / 2 - mainBoxWidth / 2

    -- Main Taskbox Shadow 
    lg.setColor(0, 0, 0, 0.2)
    lg.rectangle("fill", mainBoxX + 4, y + 4, mainBoxWidth, mainBoxHeight, 12,
                 12)

    -- Colored box 
    lg.setColor(pals.lightAccent)
    lg.rectangle("fill", mainBoxX, y, mainBoxWidth, mainBoxHeight, 12, 12)
    lg.setColor(pals.lightAccentBorder)
    lg.rectangle("line", mainBoxX, y, mainBoxWidth, mainBoxHeight, 12, 12)

end
function drawLogdata()
    local padding = 20

    -- Pick a random motivational message
    local logDescriptionMessage = "Check out your logs for today"

    -- Task Header
    lg.setFont(hhfontb)
    lg.setColor(pals.headingColor)
    lg.print("Logs", wW / 2 - hhfontb:getWidth("Logs") / 2, 75)

    lg.setFont(hfont)
    lg.print(logDescriptionMessage,
             wW / 2 - hfont:getWidth(logDescriptionMessage) / 2, 105)

    -- Main TaskBox
    local y = 150
    local mainBoxWidth, mainBoxHeight = 600, 162
    local mainBoxX = wW / 2 - mainBoxWidth / 2

    -- Main Taskbox Shadow 
    lg.setColor(0, 0, 0, 0.2)
    lg.rectangle("fill", mainBoxX + 4, y + 4, mainBoxWidth, mainBoxHeight, 12,
                 12)

    -- Colored box 
    lg.setColor(pals.lightAccent)
    lg.rectangle("fill", mainBoxX, y, mainBoxWidth, mainBoxHeight, 12, 12)
    lg.setColor(pals.lightAccentBorder)
    lg.rectangle("line", mainBoxX, y, mainBoxWidth, mainBoxHeight, 12, 12)


    local function generateDateGrid(startDate, endDate)
        local dateGrid = {}
        local current = os.time({
            year = tonumber(string.sub(startDate, 1, 4)),
            month = tonumber(string.sub(startDate, 6, 7)),
            day = tonumber(string.sub(startDate, 9, 10))
        })

        local final = os.time({
            year = tonumber(string.sub(endDate, 1, 4)),
            month = tonumber(string.sub(endDate, 6, 7)),
            day = tonumber(string.sub(endDate, 9, 10))
        })

        while current <= final do
            local dateStr = os.date("%Y-%m-%d", current)
            table.insert(dateGrid, dateStr)
            current = current + 86400 -- Add a day in Seconds
        end

        return dateGrid
    end
    -- Profile Grid Display ( 29 x 7 )
    local dateGrid = generateDateGrid(daysBeforeThisDay(os.date("%Y-%m-%d"), 29 * 7),os.date("%Y-%m-%d"))

    local gridSize = 18
    local spacing = 2
    local pGridX = mainBoxX + 12
    local pGridY = y + 13
    local horizontalGrids = 29 -- (mainBoxWidth - 20)/(gridSize * spacing)
    local verticalGrids = 7
    local mx, my = love.mouse.getPosition()
    local isHoveringOverGrid = false
    local hoveredDate = ""
    local totalCells = #dateGrid 
    local cellCounter = 1

    for i = 1, verticalGrids do
        for j = 1, horizontalGrids do
            if cellCounter > totalCells then break end
            local baseSize = gridSize

            local givenX = pGridX + ((baseSize + spacing) * (j - 1))
            local givenY = pGridY + ((baseSize + spacing) * (i - 1))

            local drawSize = baseSize
            local offset = 0

            local currentDate = dateGrid[cellCounter]
            -- Check hover
            if mx > givenX and mx < givenX + baseSize and my > givenY and my <
                givenY + baseSize then
                drawSize = baseSize * 1.2
                offset = (drawSize - baseSize) / 2
                    isHoveringOverGrid = true
                    hoveredDate = currentDate
            end

            -- Determine color based on task count (0-N)
            local taskCount = DATA.tasks[currentDate] and #DATA.tasks[currentDate] or 0
            local colorLevel = math.min(taskCount/4, 1) -- Normalize
            lg.setColor(1, 1 - colorLevel, 1 - colorLevel)



            love.graphics.rectangle("fill", givenX - offset, givenY - offset,
                                    drawSize, drawSize, 4, 4)
            lg.setColor(pals.lightAccent)
            love.graphics.rectangle("line", givenX - offset, givenY - offset,
                                    drawSize, drawSize, 4, 4)

            cellCounter = cellCounter + 1
                                end
    end

    if isHoveringOverGrid and hoveredDate then
        lg.setFont(hfontb)
        local taskNo = DATA.tasks[hovereddate] and #DATA.tasks[hoveredDate] or 0
        local taskText = hoveredDate.." " .. taskNo .. " task(s)"
        local tooltipWidth = hfontb:getWidth(taskText) + 20
        local displayX = (mx + tooltipWidth > wW) and (wW - tooltipWidth - 10) or (mx + 10)
        lg.setColor(pals.lightAccent)
        lg.rectangle("fill", displayX, my, hfontb:getWidth(taskText) + 20,
                     hfontb:getHeight() + 20, 5, 5)
        lg.setColor(pals.lightAccent)
        lg.rectangle("line", displayX, my, hfontb:getWidth(taskText) + 20,
                     hfontb:getHeight() + 20, 5, 5)
        lg.setColor(1, 1, 1)
        lg.print(taskText, displayX + 10, my + 10)
    end

end

function daysBeforeThisDay(date, no)
    local y = tonumber(string.sub(date,1, 4))
    local m = tonumber(string.sub(date,6, 7))
    local d = tonumber(string.sub(date,9, 10))
    local num = no
    print(num)
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
