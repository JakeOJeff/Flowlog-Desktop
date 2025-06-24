local home = {}

-- Library Initialization
local button = require 'src.libraries.button'


-- CLASS OOP INITIALIZATION -- 

-- Buttons
local testButton = button:new()
testButton.hover.width = 100
testButton.hover.x = 125
testButton.duration = 1

function home:load()
    

end



function home:update(dt)

    testButton:update(dt)

end


function home:draw()

    lg.print("Welcome to Flowlog Desktop <3")
    
    testButton:draw()
end


function home:keypressed(button)

end

return home

