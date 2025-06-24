local class = require 'middleclass'
local Button = class('Button')


function Button:initialize(x, y, width, height, text, callback, color, hover, duration, ext)
    self.x = x or 10
    self.y = y or 10
    self.width = width or 50
    self.height = height or 20
    self.text = text or "Button"
    self.callback = callback or function() end
    self.color = color
    self.ext = loadstring(ext) or loadstring("") -- string -> func
    self.hover = {
        x = hover.x or self.x,
        y = hover.y or self.y,
        width = hover.width or self.width,
        height = hover.height or self.height,
        text = hover.text or self.text,
        color = hover.color or self.color
    }
    self.duration = duration or 0
end

function Button:update(dt)
    

end

function Button:mousepressed(x, y, button)
    if button == 1 then
        if x >= self.x and x <= self.x + self.width and 
            y >= self.y and y <= self.y + self.height then
            self.callback()
         end
   end
end