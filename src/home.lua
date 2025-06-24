local home = {}

-- Library Initialization
local button = require 'src.libraries.button'


-- CLASS OOP INITIALIZATION -- 

-- Buttons
local testButton = button:new()
testButton.hover.width = 100
testButton.duration = 2

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

