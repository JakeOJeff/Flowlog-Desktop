local class = require 'src.packages.middleclass'
local tween = require 'src.packages.tween'

local Graphing = class("Graphing")

function Graphing:initialize(x, y, type, data, size)

    self.x = 200 -- (math.floor(x/2)) or 200
    self.y = 200 -- (math.floor(y/2))  or 200
    self.type = type or "pi"
    self.size = size or 100
    self.data = data or {
        {name = "Happiness", value = 34}, {name = "Sad", value = 75},
        {name = "Insanity", value = 500},
        {name = "Crude", value = 300},
        {name = "Truce", value = 69}
    }
    self.data = sortDataBasedOnInternalValue(self.data)
    self.totalValue = 0
    for i = 1, #self.data do
        self.totalValue = self.totalValue + self.data[i].value
    end

    for i = 1, #self.data do
        self.data[i].percent = self.data[i].value / self.totalValue
    end
    self.shades = generateColorShades(#self.data)

end

function Graphing:update(dt) end

function Graphing:draw() self:drawPIChart() end

function Graphing:drawPIChart()
    self.slicePolygons = {} -- Store each slice's polygon points

    local startAngle = 0
    for i = 1, #self.data do
        local percent = self.data[i].percent
        local angle = percent * 360

        local slicePoints = piSector(self.x, self.y, startAngle, angle,
                                     self.size)

        -- Save polygon data per slice
        self.slicePolygons[i] = {
            points = slicePoints,
            color = self.shades[i]
            --color = getColorFromPercentage(percent)
        }

        startAngle = startAngle + angle
    end

    love.graphics.setColor(1, 1, 1)
    love.graphics.circle("line", self.x, self.y, self.size, 1000)

    self:drawHoveredPieChart()
end

-- Draw a pie slice and return its points
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

    return points -- Return points for hover detection
end

function Graphing:drawHoveredPieChart()
    local mx, my = love.mouse.getPosition()
    function getPolygonCenter(points)
        local minX, maxX = points[1], points[1]
        local minY, maxY = points[2], points[2]
        for i = 3, #points, 2 do
            local x, y = points[i], points[i + 1]
            minX, maxX = math.min(minX, x), math.max(maxX, x)
            minY, maxY = math.min(minY, y), math.max(maxY, y)
        end
        return (minX + maxX) / 2, (minY + maxY) / 2
    end
    for _, slice in ipairs(self.slicePolygons) do 
                    love.graphics.setColor(slice.color)
            love.graphics.polygon("fill", slice.points)

            -- Optional: Draw border
            love.graphics.setColor(1, 1, 1)
            love.graphics.polygon("line", slice.points)
    end
    for _, slice in ipairs(self.slicePolygons) do
        if isPointInPolygon(mx, my, slice.points) then
            local cx, cy = getPolygonCenter(slice.points)
            local scaledPoints = scalePolygon(slice.points, 1.1, cx, cy)
            
            love.graphics.setColor(slice.color)
            love.graphics.polygon("fill", scaledPoints)

            -- Optional: Draw border
            love.graphics.setColor(1, 1, 1)
            love.graphics.polygon("line", scaledPoints)
            
            -- DRAW TOOLTIP
            love.graphics.setFont(hfontb)
            local tooltipText = self.data[_].name.." <"..(math.floor(self.data[_].percent * 100)) .. ">"
            local tooltipWidth = 20 + hfontb:getWidth(tooltipText)

                        -- Colored box 
            love.graphics.setColor(pals.lightAccent)
            love.graphics.rectangle("fill", mx - 10, my - 10, tooltipWidth, 20 + hfontb:getHeight(), 12, 12)
            love.graphics.setColor(pals.lightAccentBorder)
            love.graphics.rectangle("line", mx - 10, my - 10, tooltipWidth, 20 +  hfontb:getHeight(), 12, 12)
            love.graphics.setColor(0,0,0,0.2)
            love.graphics.print(tooltipText, mx + 3, my + 3)
            love.graphics.setColor(1,1,1)
            love.graphics.print(tooltipText, mx, my)
            
            break -- Only one hovered slice
        end

    end
end

-- This is a legacy system for colours
function getColorFromPercentage(p)
    local white = {1, 1, 1}
    local pink = {0.667, 0.341, 0.314}

    local r = white[1] * (1 - p) + pink[1] * p
    local g = white[2] * (1 - p) + pink[2] * p
    local b = white[3] * (1 - p) + pink[3] * p

    return {r, g, b}
end

function generateColorShades(n)
        -- Define color range endpoints
    local white = {1, 1, 1}
    local pink = {0.847, 0.561, 0.545}
    local shades = {}

    for i = 1, n do
        local t = (i - 1) / (n - 1)  -- even distribution from 0 to 1
        local r = pink[1] * (1 - t) + white[1] * t
        local g = pink[2] * (1 - t) + white[2] * t
        local b = pink[3] * (1 - t) + white[3] * t
        table.insert(shades, {r, g, b})
    end

    return shades
end

function isPointInPolygon(px, py, vertices)
    local inside = false
    local j = #vertices - 1

    for i = 1, #vertices - 1, 2 do
        local xi, yi = vertices[i], vertices[i + 1]
        local xj, yj = vertices[j], vertices[j + 1]

        local intersect = ((yi > py) ~= (yj > py)) and
                              (px < (xj - xi) * (py - yi) / (yj - yi + 0.000001) +
                                  xi)
        if intersect then inside = not inside end

        j = i
    end

    return inside
end

function scalePolygon(points, scale, cx, cy)
    local scaled = {}
    for i = 1, #points, 2 do
        local x = points[i]
        local y = points[i + 1]
        local dx = x - cx
        local dy = y - cy
        table.insert(scaled, cx + dx * scale)
        table.insert(scaled, cy + dy * scale)
    end
    return scaled
end

function sortDataBasedOnInternalValue(data)
    local givenData = data
    for i = 1, #givenData do
        for j = 1, #givenData do
            local temp = 0
            if givenData[i].value > givenData[j].value then
                temp = givenData[j]
                givenData[j] = givenData[i]
                givenData[i] = temp
            end
        end
    end
    return givenData
end


return Graphing
