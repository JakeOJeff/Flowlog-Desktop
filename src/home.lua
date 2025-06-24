local home = {}

-- Library Initialization
button = require 'src.libraries.button'


-- CLASS OOP INITIALIZATION -- 
local elements = require 'src.datalists.elements'

-- Strs 
local welcomeMessage = "Welcome to Flowlog Desktop <3"

function home:load()
    elements:load()

end



function home:update(dt)

    elements:update(dt)

end


function home:draw()
    lg.setBackgroundColor(hexToRGB("#eccea7"))

    love.graphics.setFont(font)
    lg.setColor(hexToRGB("#6a381f"))
    lg.print(welcomeMessage, wW/2 - font:getWidth(welcomeMessage)/2 , wH/2 - 25)

    lg.setColor(1,1,1)
    elements.startBtn:draw()

end


function home:keypressed(button)

end

return home

