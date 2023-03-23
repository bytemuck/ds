local element = require("element")
local color = require("color")
local SCALING = require("ui.scaling")
local FLIPMODE = require("ui.flipmode")

return element.make_new {
    cctr = function(self)
        assert(self.image)
        self.color = self.color or color.new(1, 1, 1, 1)
        self.scaling = self.scaling or SCALING.STRETCH
    end,
    draw = function(self, go)
        local pos = self.abs_pos
        local size = self.abs_size

        local iw, ih = self.image:getDimensions()
        local ew, eh = size.x, size.y
        local px, py = pos.x, pos.y

        local sx, sy = 1, 1
        if self.scaling == SCALING.STRETCH then
            sx, sy = ew/iw, eh/ih
        elseif self.scaling == SCALING.CENTER then
            local img_ratio = iw/ih
            local elem_ratio = ew/eh

            if img_ratio > elem_ratio then
                -- element has bigger y for same x
                -- so add padding on the y axis
                sx = ew/iw
                sy = sx
                ih = ih * sy
                py = py + (eh - ih) / 2
            else
                -- add padding on the x axis
                sy = eh/ih
                sx = sy
                iw = iw * sx
                px = px + (ew - iw) / 2
            end
        elseif self.scaling == SCALING.OVERFLOW_Y then
            sx = ew/iw
            sy = sx
            ih = ih * sy
            py = py + (eh - ih) / 2
        else
            error("error: scaling "..self.scaling.." not yet implemented or does not exist")
        end

        if self.flip == FLIPMODE.FLIP_X or self.flip == FLIPMODE.FLIP_XY then
            px = px + iw
            sx = -sx
        end

        if self.flip == FLIPMODE.FLIP_Y or self.flip == FLIPMODE.FLIP_XY then
            py = py + eh
            sy = -sy
        end


        love.graphics.setColor(self.color)
        if self.quad then
            love.graphics.draw(self.image, self.quad, px, py, 0, sx, sy)
        else
            love.graphics.draw(self.image, px, py, 0, sx, sy)
        end
        
        go()
    end
}
