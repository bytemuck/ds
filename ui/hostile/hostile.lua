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
    end,

    postcctr = function(self)
        self:add_children {
            sprite {
                image = self.image,
                scaling = SCALING.CENTER
            },
            sprite {
                image = assets.sprites.random,
                position = dim2(0, 0, 1, 0), -- bottom left
                size = dim2(0, 32, 0, 32), -- 32px 32px
                anchor = vec2.new(0, 1), -- bottom left
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
                position = dim2(0.5, 0, 0, -32), -- bottom left
                size = dim2(0, 32, 0, 32), -- 32px 32px
                anchor = vec2.new(0.5, 0.5), -- bottom left
            },
            button {
                on_click = {
                    [1] = function()
                        -- select hostile
                    end,               
                },
            }
        }
    end,

    -- todo: take_damage, die, generate_turn, play_turn
}