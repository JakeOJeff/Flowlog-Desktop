local elements = {}

function elements:load()
    self.startBtn = button:new()
    self.startBtn.text = "Start Flowlog"
    self.startBtn.width = 200
    self.startBtn.height = 35
    self.startBtn.x = wW/2 - self.startBtn.width/2 
    self.startBtn.y = wH/2 - self.startBtn.height/2 + 26
    self.startBtn.color = hexToRGB("#723c21")
    self.startBtn.hover.x = wW/2 - self.startBtn.width/2  - 3
    self.startBtn.hover.y = wH/2 - self.startBtn.height/2 - 3  + 26
    self.startBtn.hover.width = 206
    self.startBtn.hover.height = 41
    self.startBtn.hover.color = hexToRGB("#965535")
    self.startBtn.font = font
    self.startBtn.duration = 0.06
    self.startBtn:recall()


    self.pasteBtn = button:new()
    self.pasteBtn.text = "Enter/Paste Metadata"
    self.pasteBtn.width = 200
    self.pasteBtn.height = 35
    self.pasteBtn.x = wW/2 - self.pasteBtn.width/2 
    self.pasteBtn.y = wH/2 - self.pasteBtn.height/2 - 25
    self.pasteBtn.color = hexToRGB("#723c21")
    self.pasteBtn.hover.x = wW/2 - self.pasteBtn.width/2  - 3
    self.pasteBtn.hover.y = wH/2 - self.pasteBtn.height/2 - 3 - 25
    self.pasteBtn.hover.width = 206
    self.pasteBtn.hover.height = 41
    self.pasteBtn.hover.color = hexToRGB("#965535")
    self.pasteBtn.font = pfont
    self.pasteBtn.duration = 0.06

    self.pasteBtn:recall()


    
    self.enterFlowLogBtn = button:new()
    self.enterFlowLogBtn.text = "Run Flow"
    self.enterFlowLogBtn.width = 200
    self.enterFlowLogBtn.height = 35
    self.enterFlowLogBtn.x = wW/2 - self.pasteBtn.width/2 
    self.enterFlowLogBtn.y = wH/2 - self.pasteBtn.height/2 + 90
    self.enterFlowLogBtn.color = hexToRGB("#723c21")
    self.enterFlowLogBtn.hover.x = wW/2 - self.pasteBtn.width/2  - 3
    self.enterFlowLogBtn.hover.y = wH/2 - self.pasteBtn.height/2 - 3  + 90
    self.enterFlowLogBtn.hover.width = 206
    self.enterFlowLogBtn.hover.height = 41
    self.enterFlowLogBtn.hover.color = hexToRGB("#965535")
    self.enterFlowLogBtn.font = pfont
    self.enterFlowLogBtn.duration = 0.06

    self.enterFlowLogBtn:recall()

    self.menuButtons = {}

    for i = 1, 3 do
        local btn = button:new()
        btn.width = 150
        btn.height = 40
        btn.x = (wW/2 - btn.width/2 - (btn.width + 10) ) + (i * btn.width)
        btn.y = 20
        btn.color = hexToRGB("#723c21")

        btn.hover.x = (wW/2 - btn.width/2 - (btn.width + 10) ) + (i * btn.width) - 3
        btn.hover.y = 20 - 3
        btn.hover.width = 156
        btn.hover.height = 46
        btn.hover.color = hexToRGB("#965535")

        btn.font = pfont
        btn.duration = 0.06
        self.menuButtons[i] = btn
    end
    --In my first year of love, I made a button library which turned out to be really badd. 4 years later, I've finally made a lightweight well-made library!
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