local direct = {}

function direct:draw()

    lg.setBackgroundColor(pals.softBackground)
    love.graphics.setFont(hfont)
    lg.setColor(pals.headingColor)
    lg.print("DATA UNKNOWN/UNAVAILABLE", wW / 2 - hfont:getWidth("DATA UNKNOWN/UNAVAILABLE") / 2, wH / 2 - 100)
    love.graphics.setFont(pfont)
    lg.setColor(pals.textColor)
    local text = "There are no previous sessions available. Copy metadata from the Flowlog extension and paste the metadata after restarting. Previously saved logs/data will appear here"
    lg.printf(text, 0, wH / 2 - 75, wW, "center")
    lg.setColor(1, 1, 1)

end


return direct