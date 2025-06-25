local home = {}

-- Library Initialization
button = require 'src.libraries.button'


-- CLASS OOP INITIALIZATION -- 
local elements = require 'src.datalists.elements'

-- Strs 
local homePage = "Paste/Enter in your metadata"
local infoText = "Get the metadata from the Flowlog extension"

function home:load()
    elements:load()
    elements.pasteBtn.callback = function()

    end

end



function home:update(dt)
    elements.pasteBtn:update(dt)

end


function home:draw()
    lg.setBackgroundColor(hexToRGB("#eccea7"))

    love.graphics.setFont(font)
    lg.setColor(hexToRGB("#6a381f"))
    lg.print(homePage, wW/2 - font:getWidth(homePage)/2 , wH/2 - 25)
    love.graphics.setFont(pfont)
    lg.print(infoText, wW/2 - pfont:getWidth(infoText)/2 , wH/2)
    lg.setColor(1,1,1)
        love.graphics.setFont(pfont)
    elements.pasteBtn:draw()

end


function home:mousepressed(x, y, button)
end

return home

