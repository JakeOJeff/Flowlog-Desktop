local home = {}

-- Library Initialization
local button = require 'src.libraries.button'


-- CLASS OOP INITIALIZATION -- 

-- Buttons
local testButton = button:new()
testButton.hover.x = 115
testButton.duration = 5

function home:load()
    

end



function home:update(dt)

    testButton:update(dt)

end


function home:draw()

    testButton:draw()
end


function home:keypressed(button)

end

return home

