local elements = {}

function elements:load()
    self.startBtn = button:new()
    self.startBtn.text = "Start Flowlog"
    self.startBtn.width = 200
    self.startBtn.height = 35
    self.startBtn.x = wW / 2 - self.startBtn.width / 2
    self.startBtn.y = wH / 2 - self.startBtn.height / 2 + 26
    self.startBtn.color = pals.buttonColor
    self.startBtn.hover.x = wW / 2 - self.startBtn.width / 2 - 3
    self.startBtn.hover.y = wH / 2 - self.startBtn.height / 2 - 3 + 26
    self.startBtn.hover.width = 206
    self.startBtn.hover.height = 41
    self.startBtn.hover.color = pals.buttonHover
    self.startBtn.font = pfontb
    self.startBtn.duration = 0.06
    self.startBtn:recall()

    self.pasteBtn = button:new()
    self.pasteBtn.text = "Enter/Paste Metadata"
    self.pasteBtn.width = 200
    self.pasteBtn.height = 35
    self.pasteBtn.x = wW / 2 - self.pasteBtn.width / 2
    self.pasteBtn.y = wH / 2 - self.pasteBtn.height / 2 - 40
    self.pasteBtn.color = pals.buttonColor
    self.pasteBtn.hover.x = wW / 2 - self.pasteBtn.width / 2 - 3
    self.pasteBtn.hover.y = wH / 2 - self.pasteBtn.height / 2 - 3 - 40
    self.pasteBtn.hover.width = 206
    self.pasteBtn.hover.height = 41
    self.pasteBtn.hover.color = pals.buttonHover
    self.pasteBtn.font = pfontb
    self.pasteBtn.duration = 0.06

    self.pasteBtn:recall()

    self.enterFlowLogBtn = button:new()
    self.enterFlowLogBtn.text = "Run Flow ( WIP )"
    self.enterFlowLogBtn.width = 200
    self.enterFlowLogBtn.height = 35
    self.enterFlowLogBtn.x = wW / 2 - self.pasteBtn.width / 2
    self.enterFlowLogBtn.y = wH / 2 - self.pasteBtn.height / 2 + 100
    self.enterFlowLogBtn.color = pals.buttonColor
    self.enterFlowLogBtn.hover.x = wW / 2 - self.pasteBtn.width / 2 - 3
    self.enterFlowLogBtn.hover.y = wH / 2 - self.pasteBtn.height / 2 - 3 + 100
    self.enterFlowLogBtn.hover.width = 206
    self.enterFlowLogBtn.hover.height = 41
    self.enterFlowLogBtn.hover.color = pals.buttonHover
    self.enterFlowLogBtn.font = pfontb
    self.enterFlowLogBtn.duration = 0.06

    self.enterFlowLogBtn:recall()

    self.refreshButton = button:new()
    self.refreshButton.text = "O"
    self.refreshButton.width = 40
    self.refreshButton.height = 40
    self.refreshButton.x = 50
    self.refreshButton.y = 20
    self.refreshButton.color = pals.buttonColor
    self.refreshButton.hover.x = 50 - 3
    self.refreshButton.hover.y = 20 - 3
    self.refreshButton.hover.width = 46
    self.refreshButton.hover.height = 46
    self.refreshButton.hover.color = pals.buttonHover
    self.refreshButton.font = hfontb
    self.refreshButton.duration = 0.06

    self.refreshButton:recall()

    self.menuButtons = {}

    local totalButtons = 3
    local spacing = 10
    local buttonWidth = 150
    local totalWidth = totalButtons * buttonWidth + (totalButtons - 1) * spacing
    local startX = (wW - totalWidth) / 2

    for i = 1, totalButtons do
        local btn = button:new()
        btn.width = buttonWidth
        btn.height = 40

        -- Centering logic
        btn.x = startX + (i - 1) * (btn.width + spacing)
        btn.y = 20
        btn.color = pals.buttonColor

        -- Hover logic (slightly larger for effect)
        btn.hover.x = btn.x - 3
        btn.hover.y = btn.y - 3
        btn.hover.width = btn.width + 6
        btn.hover.height = btn.height + 6
        btn.hover.color = pals.buttonHover

        btn.font = hfontb
        btn.duration = 0.06
        btn:recall()

        self.menuButtons[i] = btn
    end

    self.menuButtons[1].text = "MOOD"
    self.menuButtons[2].text = "TASKS"
    self.menuButtons[3].text = "LOG"

    self.exitButton = button:new()
    self.exitButton.text = "X"
    self.exitButton.width = 40
    self.exitButton.height = 40
    self.exitButton.x = startX + 2 * (buttonWidth + spacing) + 178
    self.exitButton.y = 20
    self.exitButton.color = pals.buttonColor
    self.exitButton.hover.x = startX + 2 * (buttonWidth + spacing) + 178 - 3
    self.exitButton.hover.y = 20 - 3
    self.exitButton.hover.width = 46
    self.exitButton.hover.height = 46
    self.exitButton.hover.color = pals.buttonHover
    self.exitButton.font = hfontb
    self.exitButton.duration = 0.06

    self.exitButton:recall()
    -- In my first year of love, I made a button library which turned out to be really badd. 4 years later, I've finally made a lightweight well-made library!

    self.pichart = graphing:new()
    self.pichart.x = 60 + self.pichart.size
    self.pichart.y = 160 + self.pichart.size

    self.logschart = graphing:new()
    self.logschart.x = 200 + self.pichart.size
    self.logschart.y = 160 + self.pichart.size
    local logsChartTable = {}
    if DATA.tasks then
        for _, task in ipairs(DATA.tasks) do
            local taskData = {
                name = task.title,
                value = task.done
            }
            table.insert(logsChartTable, taskData)
            print("Task Data: ", taskData.name, taskData.value)
        end
        self.logschart.data = logsChartTable
    end
    self.logschart:recall()
end

function elements:update(dt)

end

-- function elements:update(dt)
--     self.startBtn:update(dt)
-- end

-- function elements:draw()
--     self.startBtn:draw()
-- end

-- function elements:mousepressed(x, y, button)
--     self.startBtn:mousepressed(x, y, button) 
-- end

return elements
