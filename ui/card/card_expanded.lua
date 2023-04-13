local element = require("element")
local card = require("ui.card.card")
local text = require("text")
local button = require("button")

local color = require("color")

local vec2 = require("vec2")
local dim2 = require("dim2")

local ALIGN = require("ui.align")

local assets = require("assets")

return element.make_new {
    cctr = function(self)
        assert(self.id)
        self.id = self.id
        self.is_pivot_side = not not self.is_pivot_side

        self.title = self.title or { effect = "Untitled", pivot = "Untitled" }
        self.description = self.description or { effect = "", pivot = "" }
    end,

    postcctr = function(self)
        local c = card {
            id = self.id,
            is_pivot_side = self.is_pivot_side,
        }

        local what = c.is_pivot_side and "pivot" or "effect"

        local title = text {
            text = tostring(self.title[what]),
            position = dim2(0.5, 0, 0.2, 0), -- center
            font = assets.fonts.roboto[36],
            color = color.new(0.3, 0.7, 0.2, 1.0),
            x_align = ALIGN.CENTER_X,
            --y_align = ALIGN.CENTER_Y
        }

        local description = text {
            text = tostring(self.description[what]),
            position = dim2(0, 8, 0.5, 0), -- center
            font = assets.fonts.roboto[36],
            color = color.new(0.2, 0.3, 0.7, 1.0),
            --x_align = ALIGN.CENTER_X,
            --y_align = ALIGN.CENTER_Y
        }


        c._contents[1]:add_children({
            title, description
        })

        self:add_child(c)
    end,
}
