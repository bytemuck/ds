local element = require("element")
local card = require("ui.card.card")
local text = require("text")
local button = require("button")
local group = require("group")

local color = require("color")

local vec2 = require("vec2")
local dim2 = require("dim2")

local ALIGN = require("ui.align")

local assets = require("assets")

return element.make_new {
    name = "card (expanded)",

    cctr = function(self)
        assert(self.id)
        self.id = self.id
        self.is_pivot_side = not not self.is_pivot_side

        self.title = self.title or "Untitled"
        self.description = self.description or "No description"

        self.isTrue = self.isTrue or false
    end,

    postcctr = function(self)
        local c = card {
            id = self.id,
            is_pivot_side = self.is_pivot_side,
            isTrue = self.isTrue
        }

        local title = text {
            text = tostring(self.title),
            position = dim2(0.5, 0, 0.2, 0), -- center
            font = assets.fonts.roboto[36],
            color = color.new(0.3, 0.7, 0.2, 1.0),
            x_align = ALIGN.CENTER_X,
            --y_align = ALIGN.CENTER_Y
        }

        local description = text {
            text = tostring(self.description),
            position = dim2(0, 8, 0.5, 0), -- center
            font = assets.fonts.roboto[36],
            color = color.new(0.2, 0.3, 0.7, 1.0),
            --x_align = ALIGN.CENTER_X,
            --y_align = ALIGN.CENTER_Y
        }

        self.title_obj = title
        self.description_obj = description

        c._contents[3]:add_children({
            title, description,
            
            text {
                position = dim2(0.16, 0, 0.86, 0),
                text = assets.cards.effect[self.id].attack,
                font = assets.fonts.roboto[60],
                x_align = ALIGN.CENTER_X,
                y_align = ALIGN.CENTER_Y,
                color = color.new(0, 0, 0, self.isTrue and 1 or 0),
            },
            text {
                position = dim2(0.83, 0, 0.86, 0),
                text = assets.cards.effect[self.id].defense,
                font = assets.fonts.roboto[60],
                x_align = ALIGN.CENTER_X,
                y_align = ALIGN.CENTER_Y,
                color = color.new(0, 0, 0, self.isTrue and 1 or 0),
            }
        })

        self:add_child(c)
    end,

    base = {
        fuck_text = function(self, yes)
            self.children[1]._contents[3].children[3].color = color.new(0, 0, 0, yes and 1 or 0)
            self.children[1]._contents[3].children[4].color = color.new(0, 0, 0, yes and 1 or 0)
        end
    }
}
