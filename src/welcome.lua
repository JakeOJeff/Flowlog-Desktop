local welcome = {}

-- Library Initialization
button = require 'src.libraries.button'


-- CLASS OOP INITIALIZATION -- 
local elements = require 'src.datalists.elements'

-- Strs 
local welcomeMessage = "Welcome to Flowlog Desktop <3"

function welcome:load()
    elements:load()

    elements.startBtn.callback = function()
        welcome.setScene("home")
    end
    local dataFiled = {
            mood = {
                currentMood = "peaceful",
                intensity = 6,
                notes = "Didn't sleep well",
                timestamp = "2025-06-26T08:30:00",
                tags = {
                    "#health", "#sleep"
                }
            },

            tasks = {
                        -- {
                        --     title = "Submit Report",
                        --     done = 6,
                        --     created = "2025-06-26",
                        --     priority = "high",
                        --     timestamp = "2025-06-26T09:00:00",
                        --     doneTime = {
                        --         "2025-06-26T10:00:00", "2025-06-26T11:30:00", "2025-06-26T11:30:00", "2025-06-26T12:00:00"
                        --     },
                        -- },
                        -- {
                        --     title = "Philipinte Pari",
                        --     done = 21,
                        --     created = "2025-06-26",
                        --     priority = "high",
                        --     timestamp = "2025-06-26T09:00:00",
                        --     doneTime = {
                        --         "2025-06-27T12:00:00", "2025-06-27T13:00:00"
                        --     },
                        -- },
                        -- {
                        --     title = "MY Task task",
                        --     done = 10,
                        --     created = "2025-06-26",
                        --     priority = "high",
                        --     timestamp = "2025-06-26T09:00:00",
                        --     doneTime = {
                        --         "2025-06-27T12:00:00", "2025-06-27T13:00:00"
                        --     },
                        -- },
                        -- {
                        --     title = "Another Task another Day",
                        --     done = 16,
                        --     created = "2025-06-26",
                        --     priority = "high",
                        --     timestamp = "2025-06-26T09:00:00",
                        --     doneTime = {
                        --         "2025-06-28T12:00:00", "2025-06-28T13:00:00"
                        --     },
                        -- },
                        -- {
                        --     title = "This shit pmo",
                        --     done = 4,
                        --     created = "2025-06-26",
                        --     priority = "high",
                        --     timestamp = "2025-06-26T09:00:00",
                        --     doneTime = {
                        --         "2025-06-29T12:00:00", "2025-06-29T13:00:00"
                        --     },
                        -- }
                    },
            streak = 0, 
        }
        local tempTable = json.encode(dataFiled)
        love.filesystem.write("data.txt", tempTable)
end



function welcome:update(dt)

    elements.startBtn:update(dt)

end


function welcome:draw()
    lg.setBackgroundColor(pals.softBackground)

    love.graphics.setFont(hfont)
    lg.setColor(pals.textColor)
    lg.print(welcomeMessage, wW/2 - hfont:getWidth(welcomeMessage)/2 , wH/2 - 25)

    lg.setColor(1,1,1)
    elements.startBtn:draw()

end


function welcome:mousepressed(x, y, button)
    elements.startBtn:mousepressed(x, y, button)
end

function welcome:keypressed(key)
    if key == "return" then
        welcome.setScene("home")     
    end
end

return welcome

