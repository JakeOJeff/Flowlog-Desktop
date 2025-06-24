local elements = {}

function elements:load()
    self.startBtn = button:new()
    self.startBtn.x = 200
    self.startBtn.color = hexToRGB("#723c21")
    self.startBtn.hover.color = hexToRGB("ffffff")
    self.startBtn.hover.x = 400
    self.startBtn:recall()

end

function elements:update(dt)
    if self.startBtn then self.startBtn:update(dt) end
end

function elements:draw()
    if self.startBtn then self.startBtn:draw() end
end

function elements:mousepressed(x, y, button)
    if self.startBtn then self.startBtn:mousepressed(x, y, button) end
end

return elements