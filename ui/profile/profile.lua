local element = require("element")
local sprite = require("sprite")

local text = require("text")
local button = require("button")

local SCALING = require("ui.scaling")
local ALIGN = require("ui.align")

local dim2 = require("dim2")
local vec2 = require("vec2")
local color = require("color")

local assets = require("assets")

return element.make_new {
    cctr = function(self)
        self.life = self.life or 3
        self.defense = self.defense or 0

        self.position = dim2(0, -20, 1, 0)
        self.anchor = vec2.new(0, 1)
        self.size = dim2(0.25, 0, 0.25, 0)
    end,

    postcctr = function(self)
        self:add_children {
            sprite {
                image = assets.sprites.profile_spirit,
                scaling = SCALING.CENTER,
            },
            sprite {
                image = assets.sprites.sword_button,
                position = dim2(0.2, 0, 0.8, 0), -- bottom left
                size = dim2(0, 48, 0, 48), -- 32px 32px
                anchor = vec2.new(0, 1), -- bottom left
                scaling = SCALING.CENTER,
                children = {
                    text {
                        text = tostring(self.life),
                        position = dim2(0.5, 0, 0.5, 0), -- center

                        font = assets.fonts.roboto[36],

                        x_align = ALIGN.CENTER_X,
                        y_align = ALIGN.CENTER_Y,
                    }
                },
            },
            sprite {
                image = assets.sprites.x_button,
                position = dim2(0.8, 0, 0.8, 0), -- bottom right
                size = dim2(0, 48, 0, 48), -- 32px 32px
                anchor = vec2.new(1, 1), -- bottom right
                scaling = SCALING.CENTER,
                children = {
                    text {
                        text = tostring(self.defense),
                        position = dim2(0.5, 0, 0.5, 0), -- center

                        font = assets.fonts.roboto[36],

                        x_align = ALIGN.CENTER_X,
                        y_align = ALIGN.CENTER_Y,
                    }
                },
            },
        }
    end,
}