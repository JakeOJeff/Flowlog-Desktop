local direct = {}
elements = require 'src.datalists.elements'

function direct:load()
    elements:load()
    elements.refreshButton.callback = function()
        direct.setScene("home")
    end
end

function direct:draw()
    lg.setBackgroundColor(pals.softBackground)
    love.graphics.setFont(hfont)
    lg.setColor(pals.headingColor)
    lg.print("DATA UNKNOWN/UNAVAILABLE", wW / 2 - hfont:getWidth("DATA UNKNOWN/UNAVAILABLE") / 2, wH / 2 - 100)
    love.graphics.setFont(pfont)
    lg.setColor(pals.textColor)
    local text =
    "There are no previous sessions available. Copy metadata from the Flowlog extension and paste the metadata after restarting. Previously saved logs/data will appear here"
    lg.printf(text, 0, wH / 2 - 75, wW, "center")
    lg.setColor(1, 1, 1)
    elements.refreshButton:draw()
end

function direct:update(dt)
    elements.refreshButton:update(dt)
end

function direct:mousepressed(x, y, button)
    elements.refreshButton:mousepressed(x, y, button)
end

return direct
