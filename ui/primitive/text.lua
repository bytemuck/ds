local element = require("element")
local color = require("color")

local assets = require("assets")
local ALIGN = require("ui.align")

return element.make_new {
    cctr = function(self)
        self.color = self.color or color.new(1, 1, 1, 1)
        self.text = self.text or ""
        self.font = self.font or assets.fonts.roboto[24]
        self.text_objs = (function()
            local o = {}
            
            local str = string.gsub(self.text, '^%s*(.-)%s*$', '%1') -- strips newlines at start and end of string
            for line in string.gmatch(str, "([^\n]*)\n?") do
                table.insert(o, { text = line, obj = love.graphics.newText(self.font, line) })
            end

            return o
        end)()
        self.x_align = self.x_align or ALIGN.TOP
        self.y_align = self.y_align or ALIGN.LEFT
    end,
    draw = function(self, go)
        local pos = self.abs_pos

        local i = math.floor(#self.text_objs / 2)
        local j = 0
        love.graphics.setColor(self.color)
        for k,v in pairs(self.text_objs) do
            local font_height = self.font:getHeight()
            local total_height = self.font:getHeight() * #self.text_objs

            local offset_x = 0
            local offset_y = 0

            if self.x_align == ALIGN.CENTER_X then
                offset_x = -self.font:getWidth(v.text) / 2
            end

            if self.y_align == ALIGN.CENTER_Y then
                offset_y = (font_height * i) - (total_height) + (font_height / 2)
            else
                offset_y = font_height * j
            end

            love.graphics.draw(v.obj, pos.x + offset_x, pos.y + offset_y)
            i = i + 1
            j = j + 1
        end

        go()
    end
}
