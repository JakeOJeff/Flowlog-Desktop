local elements = {}

function elements:load()
    self.startBtn = button:new()
    self.startBtn.text = "Start Flowlog"
    self.startBtn.width = 200
    self.startBtn.height = 35
    self.startBtn.x = wW / 2 - self.startBtn.width / 2
    self.startBtn.y = wH / 2 - self.startBtn.height / 2 + 26
    self.startBtn.color = hexToRGB("#906c4e")
    self.startBtn.hover.x = wW / 2 - self.startBtn.width / 2 - 3
    self.startBtn.hover.y = wH / 2 - self.startBtn.height / 2 - 3 + 26
    self.startBtn.hover.width = 206
    self.startBtn.hover.height = 41
    self.startBtn.hover.color = hexToRGB("#92765e")
    self.startBtn.font = font
    self.startBtn.duration = 0.06
    self.startBtn:recall()

    self.pasteBtn = button:new()
    self.pasteBtn.text = "Enter/Paste Metadata"
    self.pasteBtn.width = 200
    self.pasteBtn.height = 35
    self.pasteBtn.x = wW / 2 - self.pasteBtn.width / 2
    self.pasteBtn.y = wH / 2 - self.pasteBtn.height / 2 - 40
    self.pasteBtn.color = hexToRGB("#906c4e")
    self.pasteBtn.hover.x = wW / 2 - self.pasteBtn.width / 2 - 3
    self.pasteBtn.hover.y = wH / 2 - self.pasteBtn.height / 2 - 3 - 40
    self.pasteBtn.hover.width = 206
    self.pasteBtn.hover.height = 41
    self.pasteBtn.hover.color = hexToRGB("#92765e")
    self.pasteBtn.font = pfont
    self.pasteBtn.duration = 0.06

    self.pasteBtn:recall()

    self.enterFlowLogBtn = button:new()
    self.enterFlowLogBtn.text = "Run Flow"
    self.enterFlowLogBtn.width = 200
    self.enterFlowLogBtn.height = 35
    self.enterFlowLogBtn.x = wW / 2 - self.pasteBtn.width / 2
    self.enterFlowLogBtn.y = wH / 2 - self.pasteBtn.height / 2 + 100
    self.enterFlowLogBtn.color = hexToRGB("#906c4e")
    self.enterFlowLogBtn.hover.x = wW / 2 - self.pasteBtn.width / 2 - 3
    self.enterFlowLogBtn.hover.y = wH / 2 - self.pasteBtn.height / 2 - 3 + 100
    self.enterFlowLogBtn.hover.width = 206
    self.enterFlowLogBtn.hover.height = 41
    self.enterFlowLogBtn.hover.color = hexToRGB("#92765e")
    self.enterFlowLogBtn.font = pfont
    self.enterFlowLogBtn.duration = 0.06

    self.enterFlowLogBtn:recall()

    self.exitButton = button:new()
    self.exitButton.text = "▼"
    self.exitButton.width = 20
    self.exitButton.height = 20
    self.exitButton.x = 10
    self.exitButton.y = 20
    self.exitButton.color = hexToRGB("#906c4e")
    self.exitButton.hover.x = 10 - 3
    self.exitButton.hover.y = 20 - 3
    self.exitButton.hover.width = 26
    self.exitButton.hover.height = 26
    self.exitButton.hover.color = hexToRGB("#92765e")
    self.exitButton.font = lg.getFont()
    self.exitButton.duration = 0.06

    self.exitButton:recall()

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
        btn.color = hexToRGB("#906c4e")

        -- Hover logic (slightly larger for effect)
        btn.hover.x = btn.x - 3
        btn.hover.y = btn.y - 3
        btn.hover.width = btn.width + 6
        btn.hover.height = btn.height + 6
        btn.hover.color = hexToRGB("#92765e")

        btn.font = hfont
        btn.duration = 0.06
        btn:recall()

        self.menuButtons[i] = btn
    end

    self.menuButtons[1].text = "MOOD"
    self.menuButtons[2].text = "TASKS"
    self.menuButtons[3].text = "LOG"
    -- In my first year of love, I made a button library which turned out to be really badd. 4 years later, I've finally made a lightweight well-made library!
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
