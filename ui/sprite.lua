local ui = require("ui.base")
local color = require("ui.color")

return ui.make_new {
    cctr = function(self)
        assert(self.image)
        self.color = self.color or color.new(1, 1, 1, 1)
    end,
    draw = function(self)
        local pos = self.abs_pos
        local size = self.abs_size

        local iw, ih = self.image:getDimensions()

        love.graphics.setColor(self.color)
        love.graphics.draw(self.image, pos.x, pos.y, 0, size.x/iw, size.y/ih)
    end
}
