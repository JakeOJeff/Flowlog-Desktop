local elements = {

    startBtn = button:new(),

}

-- Element Edition

elements.startBtn.x = 100
elements.startBtn.y = 100
elements.startBtn.width = 100
elements.startBtn.height = 35
elements.startBtn.color = hexToRGB("#6a381f")


function elements:update(dt)
    self.startBtn:update(dt)
end

function elements:draw()

end

function elements:mousepressed(x, y, button)

end

return elements