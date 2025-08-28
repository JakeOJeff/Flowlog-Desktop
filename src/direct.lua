local direct = {}

function direct:draw()

    lg.setBackgroundColor(pals.softBackground)
    love.graphics.setFont(hfont)
    lg.setColor(pals.headingColor)
    lg.print("Direct Input", wW / 2 - hfont:getWidth("Direct Input") / 2, wH / 2 - 100)
    love.graphics.setFont(pfont)
    lg.setColor(pals.textColor)
    local text = "This feature will allow you to directly input your Flowlog data in the app. This is useful for mobile users who cannot easily copy data from the web app."
    lg.print(text, wW / 2 - pfont:getWidth(text) / 2, wH / 2 - 75)
    lg.setColor(1, 1, 1)
end

return direct