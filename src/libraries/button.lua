local class = require 'middleclass'
local Button = class('Button')


function Button:initialize(x, y, width, height, text, callback)
    self.x = x or 10
    self.y = y or 10
    self.width = width or 50
    self.height = height or 20
    self.text = text or "Button"
    self.callback = callback or function() end
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