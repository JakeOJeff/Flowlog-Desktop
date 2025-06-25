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
    self.startBtn.hover.height = 56
    self.startBtn.hover.color = hexToRGB("#965535")
    self.font = font

    self.startBtn:recall()


    self.pasteBtn = button:new()
    self.pasteBtn.text = "Enter/Paste Metadata"
    self.pasteBtn.width = 200
    self.pasteBtn.height = 35
    self.pasteBtn.x = wW/2 - self.pasteBtn.width/2 
    self.pasteBtn.y = wH/2 - self.pasteBtn.height/2 + 26
    self.pasteBtn.color = hexToRGB("#723c21")
    self.pasteBtn.hover.x = wW/2 - self.pasteBtn.width/2  - 3
    self.pasteBtn.hover.y = wH/2 - self.pasteBtn.height/2 - 3  + 26
    self.pasteBtn.hover.width = 206
    self.pasteBtn.hover.height = 56
    self.pasteBtn.hover.color = hexToRGB("#965535")
    self.font = pfont

    self.pasteBtn:recall()
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