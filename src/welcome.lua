local welcome = {}

-- Library Initialization
button = require 'src.libraries.button'


-- CLASS OOP INITIALIZATION -- 
local elements = require 'src.datalists.elements'

-- Strs 
local welcomeMessage = "Welcome to Flowlog Desktop <3"

function welcome:load()
    elements:load()

    elements.startBtn.callback = function()
        welcome.setScene("home")
    end
    
end



function welcome:update(dt)

    elements.startBtn:update(dt)
end


function welcome:draw()
    lg.setBackgroundColor(hexToRGB("#eccea7"))

    love.graphics.setFont(hfont)
    lg.setColor(hexToRGB("#906c4e"))
    lg.print(welcomeMessage, wW/2 - hfont:getWidth(welcomeMessage)/2 , wH/2 - 25)

    lg.setColor(1,1,1)
    elements.startBtn:draw()

end


function welcome:mousepressed(x, y, button)
    elements.startBtn:mousepressed(x, y, button)
end

return welcome

