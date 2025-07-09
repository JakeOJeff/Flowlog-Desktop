-- Main TaskBox
local y = 150
local mainBoxWidth, mainBoxHeight = 600, 450
local mainBoxX = wW / 2 - mainBoxWidth / 2
function drawTasksData()
    local padding = 20

    local motivationMessages = {"You've been doing so well so far", "Proud of you how far you've come along.",
                                "Take a break and relax whenever you need to.",
                                "Don't forget to rest every once in a while!",
                                "If you ever feel down or burnt out, don't forget to take a rest!",
                                "Don't feel ashamed to take a rest if you are exhausted",
                                "Proud of the progress you've accomplished so far!"}

    local taskDoneMessages = {"You have so much potential today!", "You are doing so good so far.",
                              "You are doing so well!", "You have been brilliant today!",
                              "You have had exceptional motivation today!",
                              "At this pace, you are having exceptional self-growth!",
                              "It is insanely inspiring how committed you are to this!", "You are unstoppable today!"}
    local doneTasksToday = 30

    -- Pick a random motivational message
    local tasksDescriptionMessage = taskDoneMessages[math.floor(doneTasksToday / 10)] or
                                        taskDoneMessages[#taskDoneMessages]

    -- Task Header
    lg.setFont(hhfontb)
    lg.setColor(pals.headingColor)
    lg.print("Tasks", wW / 2 - hhfontb:getWidth("Tasks") / 2, 75)

    lg.setFont(hfont)
    lg.print(tasksDescriptionMessage, wW / 2 - hfont:getWidth(tasksDescriptionMessage) / 2, 105)

    -- Main Taskbox Shadow 
    lg.setColor(0, 0, 0, 0.2)
    lg.rectangle("fill", mainBoxX + 4, y + 4, mainBoxWidth, mainBoxHeight, 12, 12)

    -- Colored box 
    lg.setColor(pals.lightAccent)
    lg.rectangle("fill", mainBoxX, y, mainBoxWidth, mainBoxHeight, 12, 12)
    lg.setColor(pals.lightAccentBorder)
    lg.rectangle("line", mainBoxX, y, mainBoxWidth, mainBoxHeight, 12, 12)
    updateMaxScroll()
    local startY = y + scrollOffset + 25
    for i, task in ipairs(DATA.tasks) do
        makeTaskCard(i, startY + (i - 1) * 190) -- Adjust spacing
    end

end

function makeTaskCard(taskID, scrY)
    task = DATA.tasks[taskID]
    local cardWidth, cardHeight = mainBoxWidth / 1.1, mainBoxHeight / 2.5

    local cardX, cardY = mainBoxX + (mainBoxWidth / 2 - cardWidth / 2), scrY

    -- Main Taskbox Shadow 
    lg.setColor(0, 0, 0, 0.2)
    lg.rectangle("fill", cardX + 4, cardY + 4, cardWidth, cardHeight, 12, 12)

    lg.setColor(pals.lightAccent)
    lg.rectangle("fill", cardX, cardY, cardWidth, cardHeight, 12, 12)
    lg.setColor(pals.lightAccentBorder)
    lg.rectangle("line", cardX, cardY, cardWidth, cardHeight, 12, 12)

    lg.setColor(pals.headingColor)
    lg.setFont(hhfont)
    lg.print(task.title, cardX + 20, cardY + 20)

    -- elements.taskcharts[taskID]:draw()

end
function updateMaxScroll()
    local totalHeight = #DATA.tasks * 190 -- Task height + spacing
    maxScroll = math.max(0, totalHeight - mainBoxHeight + 40)
end
