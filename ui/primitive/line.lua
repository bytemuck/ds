local element = require("element")
local color = require("color")

return element.make_new {
    name = "line",

    cctr = function(self)
        self.color = self.color or color.new(1, 1, 1, 1)

        self.border_size = self.border_size or 0
        self.border_color = self.border_color or color.new(1, 1, 1, 1)
    end,
    draw = function(self, go)
        local pos = self.abs_pos
        local size = self.abs_size
        love.graphics.setColor(self.color)
        love.graphics.line(pos.x, pos.y, size.x, size.y)

        go()
    end
}
