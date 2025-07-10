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
                           "You're doing your best, and that's enough. ( andi )"

    -- Mood Header
    lg.setFont(hhfontb)
    lg.setColor(pals.headingColor)
    lg.print("Mood", wW / 2 - hhfontb:getWidth("Mood") / 2, 75)

    lg.setFont(hfont)
    local timeWelcomeMessage = getTimeOfDay() .. "! Orangada Myre"
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
