local home = {}

-- Library Initialization
button = require 'src.libraries.button'


-- CLASS OOP INITIALIZATION -- 
local elements = require 'src.datalists.elements'

-- Strs 
local homeText = "Paste/Enter in your metadata"
local infoText = "Get the metadata from the Flowlog extension"
local home2Text = "Use Flowlog on your Desktop"
local info2Text = "Flowlog can now work on desktop as well!"

function home:load()
    elements:load()
    elements.pasteBtn.callback = function()

    end

    elements.enterFlowLogBtn.callback = function()
        
    end
end



function home:update(dt)
    elements.pasteBtn:update(dt)
    elements.enterFlowLogBtn:update(dt)
end


function home:draw()
    lg.setBackgroundColor(hexToRGB("#eccea7"))

    love.graphics.setFont(hfont)
    lg.setColor(hexToRGB("#6a381f"))
    lg.print(homeText, wW/2 - hfont:getWidth(homeText)/2 , wH/2 - 85)
    love.graphics.setFont(pfont)
    lg.print(infoText, wW/2 - pfont:getWidth(infoText)/2 , wH/2 - 60)
    lg.setColor(1,1,1)
    love.graphics.setFont(pfont)
    elements.pasteBtn:draw()

    lg.setColor(hexToRGB("#6a381f"))
    love.graphics.setFont(hhfont)
    lg.print("OR", wW/2 - hfont:getWidth("OR")/2 , wH/2)

    love.graphics.setFont(hfont)
    lg.print(home2Text, wW/2 - hfont:getWidth(home2Text)/2 , wH/2 + 30)
    love.graphics.setFont(pfont)
    lg.print(info2Text, wW/2 - pfont:getWidth(info2Text)/2 , wH/2 + 55)
    lg.setColor(1,1,1)
    love.graphics.setFont(pfont)
    elements.enterFlowLogBtn:draw()

end


function home:mousepressed(x, y, button)
end

return home

