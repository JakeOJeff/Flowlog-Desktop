local class = require 'src.packages.middleclass'
local tween = require 'src.packages.tween'

local Button = class('Button')

function Button:initialize(x, y, width, height, text, callback, color, hover,
                           duration, ext)
    self.x = x or 10
    self.y = y or 10
    self.width = width or 50
    self.height = height or 20
    self.text = text or "Button"
    self.color = color or {1, 1, 1}

    self.callback = callback or function() end
    -- self.ext = load(ext) or load('print("no Function")') -- charString -> func
    hover = hover or {}
    self.state = {
        x = self.x,
        y = self.y,
        width = self.width,
        height = self.height,
        color = {unpack(self.color)}
    }
    self.normal = {
        x = self.x,
        y = self.y,
        width = self.width,
        height = self.height,
        color = {unpack(self.color)}
    }

    self.hover = {
        x = hover.x or self.x,
        y = hover.y or self.y,
        width = hover.width or self.width,
        height = hover.height or self.height,
        color = {unpack(hover.color or self.color)}
    }

    self.duration = duration or 0.3

    return self
end
function Button:recall()
    self.state = {
        x = self.x,
        y = self.y,
        width = self.width,
        height = self.height,
        color = {unpack(self.color)}
    }
    self.normal = {
        x = self.x,
        y = self.y,
        width = self.width,
        height = self.height,
        color = {unpack(self.color)}
    }
end
function Button:update(dt)
    local mx, my = love.mouse.getPosition()

    if mx > self.x and mx < self.x + self.width and my > self.y and my < self.y +
        self.height then
        self.tweenHover = tween.new(self.duration, self.state, self.hover)
        self.tweenHover:update(dt)
    else

        self.tweenReset = tween.new(self.duration, self.state, self.normal)
        self.tweenReset:update(dt)
    end

end

function Button:mousepressed(x, y, button)
    if button == 1 then
        if x >= self.x and x <= self.x + self.width and y >= self.y and y <=
            self.y + self.height then self.callback() end
    end
end

function Button:draw()
    love.graphics.setColor(self.state.color)
    love.graphics.rectangle("fill", self.state.x, self.state.y,
                            self.state.width, self.state.height)
    love.graphics.setColor(1,1,1)
    love.graphics.print(self.text,
                        self.state.x + self.state.width/2 - font:getWidth(self.text)/2,
                    self.state.y + self.state.height/2 - font:getHeight()/2)
    love.graphics.setColor(1, 1, 1) -- Reset to default
end
return Button
