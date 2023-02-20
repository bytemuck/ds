local element = require("element")
local color = require("color")

return element.make_new {
    cctr = function(self)
        assert(self.image)
        self.color = self.color or color.new(1, 1, 1, 1)
    end,
    draw = function(self, go)
        local pos = self.abs_pos
        local size = self.abs_size

        local iw, ih = self.image:getDimensions()

        love.graphics.setColor(self.color)
        love.graphics.draw(self.image, pos.x, pos.y, 0, size.x/iw, size.y/ih)

        go()
    end
}
