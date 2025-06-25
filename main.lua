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

hhfont = love.graphics.newFont("assets/cour.ttf", 28)
hhfontb = love.graphics.newFont("assets/cour_b.ttf", 28)
hfont = love.graphics.newFont("assets/cour.ttf", 22)
hfontb = love.graphics.newFont("assets/cour_b.ttf", 22)
pfont = love.graphics.newFont("assets/cour.ttf", 14)


-- All necessary UTILITY functions ( To be added later)

function hexToRGB(hex)

    hex = hex:gsub("#", "")

    if #hex == 3 then
        hex = hex:sub(1,1):rep(2)..hex:sub(2,2):rep(2)..hex:sub(3,3):rep(2)
    end

    local r = tonumber(hex:sub(1,2), 16)/255
    local g = tonumber(hex:sub(3,4), 16)/255
    local b = tonumber(hex:sub(5,6), 16)/255

    return {r, g, b}

end

local scenery = SceneryInit(
    {
        path = "src.welcome";
        key = "welcome";
        default = true;
    },
    {
        path = "src.home";
        key = "home";
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


