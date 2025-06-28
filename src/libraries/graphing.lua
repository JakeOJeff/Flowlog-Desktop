local class = require 'src.packages.middleclass'
local tween = require 'src.packages.tween'

local Graphing = class("Graphing")

function Graphing:initialize(x, y, type, data, size)

    self.x = 200--(math.floor(x/2)) or 200
    self.y = 200--(math.floor(y/2))  or 200
    self.type = type or "pi"
    self.size = size or 100
    self.data = data or {
        {
            name = "tag1",
            value = 34,
        },
        {
            name = "tag2",
            value = 300
        },
        {
            name = "tag3",
            value = 54
        }
    }
    self.totalValue = 0
    for i = 1, #self.data do
        self.totalValue = self.totalValue + self.data[i].value
    end
    
    for i = 1, #self.data do
        self.data[i].percent = self.data[i].value / self.totalValue
    end
end


function Graphing:update(dt)

end

function Graphing:draw()
    self:drawPIChart()
end

function Graphing:drawPIChart()


    local startAngle = 0
    for i = 1, #self.data do
        local percent = self.data[i].percent
        local angle = percent * 360

        love.graphics.setColor(getColorFromPercentage(percent))
        piSector(self.x, self.y, startAngle, angle, self.size)

        startAngle = startAngle + angle
    end
        love.graphics.setColor(1, 1, 1)
    love.graphics.circle("line", self.x, self.y, self.size, 1000)
end



function piSector(x, y, startAngleDeg, angleDeg, radius)
    local startRad = math.rad(startAngleDeg)
    local angleRad = math.rad(angleDeg)
    local segments = math.max(3, math.ceil(radius * angleDeg / 45))

    local points = {x, y}

    for i = 0, segments do
        local theta = startRad + i / segments * angleRad
        local px = x + math.cos(theta) * radius
        local py = y + math.sin(theta) * radius
        table.insert(points, px)
        table.insert(points, py)
    end

    love.graphics.polygon("fill", points)
end

function getColorFromPercentage(p)
    
    local highest = {0.847, 0.561, 0.545}

    r = highest[1] * p
    g = highest[2] * p
    b = highest[3] * p 


    return {r, g, b}
end
return Graphing
