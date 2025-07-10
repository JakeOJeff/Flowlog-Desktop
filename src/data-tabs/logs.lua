function drawLogdata()
    local padding = 20

    -- Pick a random motivational message
    local logDescriptionMessage = "Check out your logs for today"

    -- Task Header
    lg.setFont(hhfontb)
    lg.setColor(pals.headingColor)
    lg.print("Logs", wW / 2 - hhfontb:getWidth("Logs") / 2, 75)

    lg.setFont(hfont)
    lg.print(logDescriptionMessage, wW / 2 - hfont:getWidth(logDescriptionMessage) / 2, 105)

    -- Main TaskBox
    local y = 150
    local mainBoxWidth, mainBoxHeight = 600, 162
    local mainBoxX = wW / 2 - mainBoxWidth / 2

    -- Main Taskbox Shadow 
    lg.setColor(0, 0, 0, 0.2)
    lg.rectangle("fill", mainBoxX + 4, y + 4, mainBoxWidth, mainBoxHeight, 12, 12)

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
    local dateGrid = generateDateGrid(daysBeforeThisDay(os.date("%Y-%m-%d"), 29 * 7), os.date("%Y-%m-%d"))

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

    -- Count tasks grouped by date
    local taskCountByDate = {}
    for _, task in ipairs(DATA.tasks) do
        if task.created then
            taskCountByDate[task.created] = (taskCountByDate[task.created] or 0) + 1
        end
    end

    -- Draw the grid
    for i = 1, verticalGrids do
        for j = 1, horizontalGrids do
            if cellCounter > totalCells then
                break
            end

            local baseSize = gridSize
            local givenX = pGridX + ((baseSize + spacing) * (j - 1))
            local givenY = pGridY + ((baseSize + spacing) * (i - 1))

            local drawSize = baseSize
            local offset = 0

            local currentDate = dateGrid[cellCounter]
            local taskCount = taskCountByDate[currentDate] or 0

            -- Hover detection
            if mx > givenX and mx < givenX + baseSize and my > givenY and my < givenY + baseSize then
                drawSize = baseSize * 1.2
                offset = (drawSize - baseSize) / 2
                isHoveringOverGrid = true
                hoveredDate = currentDate
            end

            -- Color by task count
            local colorLevel = math.min(taskCount / 4, .5)
            lg.setColor(1, 1 - colorLevel, 1 - colorLevel)

            love.graphics.rectangle("fill", givenX - offset, givenY - offset, drawSize, drawSize, 4, 4)
            lg.setColor(pals.lightAccent)
            love.graphics.rectangle("line", givenX - offset, givenY - offset, drawSize, drawSize, 4, 4)

            cellCounter = cellCounter + 1
        end
    end

    -- Tooltip on hover
    if isHoveringOverGrid and hoveredDate then
        lg.setFont(hfontb)
        local taskNo = taskCountByDate[hoveredDate] or 0
        local taskText = hoveredDate .. " " .. taskNo .. " task(s)"
        local tooltipWidth = hfontb:getWidth(taskText) + 20
        local tooltipHeight = hfontb:getHeight() + 20
        local displayX = (mx + tooltipWidth > wW) and (wW - tooltipWidth - 10) or (mx + 10)
        local displayY = (my > (y + mainBoxHeight/1.3)) and (y + mainBoxHeight - 20 - tooltipHeight - 10) or (my + 10)

        lg.setColor(pals.lightAccent)
        lg.rectangle("fill", displayX, displayY, tooltipWidth, tooltipHeight, 5, 5)
        lg.setColor(pals.lightAccent)
        lg.rectangle("line", displayX, displayY, tooltipWidth, tooltipHeight, 5, 5)
        lg.setColor(1, 1, 1)
        lg.print(taskText, displayX + 10, displayY + 10)
    end

    -- Second Taskbox Shadow 
    y = y + mainBoxHeight + 20
    local secondaryBoxX = mainBoxX
    local secondaryBoxWidth = mainBoxWidth
    local secondaryBoxHeight = mainBoxHeight + 25

    lg.setColor(0, 0, 0, 0.2)
    lg.rectangle("fill", secondaryBoxX + 4, y + 4, secondaryBoxWidth, secondaryBoxHeight, 12, 12)

    -- Colored box 
    lg.setColor(pals.lightAccent)
    lg.rectangle("fill", secondaryBoxX, y, secondaryBoxWidth, secondaryBoxHeight, 12, 12)
    lg.setColor(pals.lightAccentBorder)
    lg.rectangle("line", secondaryBoxX, y, secondaryBoxWidth, secondaryBoxHeight, 12, 12)

    -- Seperator Line 
    lg.rectangle("fill", secondaryBoxX + wW / 1.7, y + 12, 5, secondaryBoxHeight - 18, 10, 10)

    elements.logschart:draw()
end
