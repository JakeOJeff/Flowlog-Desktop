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
        local dataReceived = love.system.getClipboardText()
        local dataFiled = {
            mood = {
                currentMood = "happy",
                intensity = 6,
                notes = "Didn't sleep well",
                timestamp = "2025-06-26T08:30:00",
                tags = {"#health", "#sleep", "#tired"}
            },
            tasks = {
                {
                    title = "Submit Report",
                    done = false,
                    due = "2025-06-26",
                    priority = "high",
                    timestamp = "2025-06-26T09:00:00",
                    doneTime = nil,
                    tags = {"#work"}
                }
            },
            log = {
                timestamp = "2025-06-26T10:00:00",
                mood = "calm",
                task = "Morning meditation",
                note = "Felt peaceful after 10 minutes of breathing"
            }
        }
        local tempTable = json.encode(dataFiled)
        love.filesystem.write("data.txt", tempTable)
        home.setScene("data")
    end

    elements.enterFlowLogBtn.callback = function() home.setScene("direct") end
end

function home:update(dt)
    elements.pasteBtn:update(dt)
    elements.enterFlowLogBtn:update(dt)
end

function home:draw()
    lg.setBackgroundColor(hexToRGB("#eccea7"))

    love.graphics.setFont(hfont)
    lg.setColor(hexToRGB("#906c4e"))
    lg.print(homeText, wW / 2 - hfont:getWidth(homeText) / 2, wH / 2 - 100)
    love.graphics.setFont(pfont)
    lg.print(infoText, wW / 2 - pfont:getWidth(infoText) / 2, wH / 2 - 75)
    lg.setColor(1, 1, 1)
    love.graphics.setFont(pfont)
    elements.pasteBtn:draw()

    lg.setColor(hexToRGB("#906c4e"))
    love.graphics.setFont(hhfont)
    lg.print("OR", wW / 2 - hfont:getWidth("OR") / 2, wH / 2)

    love.graphics.setFont(hfont)
    lg.print(home2Text, wW / 2 - hfont:getWidth(home2Text) / 2, wH / 2 + 40)
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

return home

