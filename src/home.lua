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
        receivedData = love.system.getClipboardText()

        home.setScene("data")
    end

    elements.enterFlowLogBtn.callback = function() if love.filesystem.read("data.txt") then
            receivedData = love.filesystem.read("data.txt")
            home.setScene("data")
        else home.setScene("direct") end end
end

function home:update(dt)
    elements.pasteBtn:update(dt)
    elements.enterFlowLogBtn:update(dt)
end

function home:draw()
    lg.setBackgroundColor(pals.softBackground)

    love.graphics.setFont(hfont)
    lg.setColor(pals.headingColor)
    lg.print(homeText, wW / 2 - hfont:getWidth(homeText) / 2, wH / 2 - 100)
    love.graphics.setFont(pfont)
    lg.setColor(pals.textColor)
    lg.print(infoText, wW / 2 - pfont:getWidth(infoText) / 2, wH / 2 - 75)
    lg.setColor(1, 1, 1)
    love.graphics.setFont(pfont)
    elements.pasteBtn:draw()

    lg.setColor(pals.headingColor)
    love.graphics.setFont(hhfont)
    lg.print("OR", wW / 2 - hhfont:getWidth("OR") / 2, wH / 2)

    love.graphics.setFont(hfont)
    lg.print(home2Text, wW / 2 - hfont:getWidth(home2Text) / 2, wH / 2 + 40)
    lg.setColor(pals.textColor)
    love.graphics.setFont(pfont)
    lg.print(info2Text, wW / 2 - pfont:getWidth(info2Text) / 2, wH / 2 + 65)
    lg.setColor(1, 1, 1)
    love.graphics.setFont(pfont)
    elements.enterFlowLogBtn:draw()
end

function home:mousepressed(x, y, button)
    elements.pasteBtn:mousepressed(x, y, button)
    elements.enterFlowLogBtn:mousepressed(x, y, button)
end

function home:keypressed(key)
    if key == "return" then
        home.setScene("data")
    end
end

return home
