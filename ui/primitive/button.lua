local element = require("element")
local color = require("color")

local presses = require("mouse")

return element.make_new {
    cctr = function(self)
        self.mouse_button = self.mouse_button or 1

        self.default_color = self.default_color or color.new(0, 0, 0, 0)
        self.hover_color = self.hover_color or color.new(0, 0, 0, 0.25)
        self.click_color = self.click_color or color.new(0.2, 0.2, 0.2, 0.2)

        self.color = self.default_color
    end,
    draw = function(self, go)
        go()

        local pos = self.abs_pos
        local size = self.abs_size
        love.graphics.setColor(self.color)
        love.graphics.rectangle("fill", pos.x, pos.y, size.x, size.y)
    end,
    update = function(self)
        local x, y = love.mouse.getPosition()

        local pos = self.abs_pos
        local size = self.abs_size
        x = x - pos.x
        y = y - pos.y

        local over = (x > 0 and x < size.x) and (y > 0 and y < size.y)
        self.over = over

        if over then
            for i in pairs(presses) do
                if love.mouse.isDown(i) then
                    self.color = self.click_color
                    if self.on_click and self.on_click[i] then
                        self.on_click[i](x, y)
                    end
                else
                    self.color = self.hover_color
                end
            end
        else
            self.color = self.default_color
        end
    end
}
