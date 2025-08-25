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

scrollOffset = 0
maxScroll = 0

deffont = love.graphics.getFont()

hhfont = love.graphics.newFont("assets/fonts/Quicksand_Book.otf", 32)
hhfontb = love.graphics.newFont("assets/fonts/Quicksand_Bold.otf", 32)
hfont = love.graphics.newFont("assets/fonts/Quicksand_Book.otf", 24)
hfontb = love.graphics.newFont("assets/fonts/Quicksand_Bold.otf", 24)
pfont = love.graphics.newFont("assets/fonts/Quicksand_Book.otf", 16)
pfontb = love.graphics.newFont("assets/fonts/Quicksand_Bold.otf", 16)
tagfont = love.graphics.newFont("assets/fonts/Nunito-Regular.ttf", 20)

-- Color palette
pals = {
    softBackground = {0.949, 0.866, 0.866},  -- #f2dddd
    lightAccent    = {0.898, 0.663, 0.663},  -- #e5a9a9
    lightAccentBorder = {0.949, 0.796, 0.796},  -- approx #f2cbcb
    buttonColor    = {0.776, 0.478, 0.463},  -- #c67a76
    buttonHover     = {0.847, 0.561, 0.545},  -- #d88f8b
    headingColor   = {0.667, 0.341, 0.314},  -- #aa5750
    textColor      = {0.459, 0.227, 0.200}   -- #753a33
}

receivedData = nil --love.filesystem.read("data.txt")

-- File Initialization

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
    },
    {
        path = "src.data";
        key = "data";
    },
        {
        path = "src.direct";
        key = "direct";
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



function love.wheelmoved(x, y)
    scrollOffset = scrollOffset + y * 30  -- 30 is scroll speed
    scrollOffset = math.max(math.min(scrollOffset, 0), -maxScroll) -- Clamp
end
