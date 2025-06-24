local SceneryInit = require("scenery")

lg = love.graphics
lm = love.mouse
lk = love.keyboard
la = love.audio
lf = love.filesystem

defW = love.graphics.getWidth()
defH = love.graphics.getHeight()
wW = defW
wH = defH

zoomFactor = 1
scale = wH/defH * zoomFactor

local scenery = SceneryInit(
    {
        path = "src.home";
        key = "home";
        default = true;
    }
)

scenery:hook(love) -- Hook scenery to love callback functions


-- Global funcs()
 
    -- To be added later

-- Window resize callback
function love.resize(w, h)
    wW = w
    wH = h
    scaleReset()

end


-- All necessary UTILITY functions ( To be added later)

