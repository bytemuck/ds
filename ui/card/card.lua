local element = require("element")
local color = require("color")
local assets = require("assets")

local dim2 = require("dim2")
local vec2 = require("vec2")

local sprite = require("sprite")
local group = require("group")
local button = require("button")

local SCALING = require("ui.scaling")

local RARITY = require("rarity")

local rarity_accountrement = {
    [RARITY.COMMON] = assets.sprites.card_accountrement.common,
    [RARITY.RARE] = assets.sprites.card_accountrement.rare,
    [RARITY.EPIC] = assets.sprites.card_accountrement.epic,
    [RARITY.LEGENDARY] = assets.sprites.card_accountrement.legendary,
}

local rarity_background_effect = {
    [RARITY.COMMON] = assets.sprites.card_background.common_effect
}

local rarity_background_pivot = {
    [RARITY.COMMON] = assets.sprites.card_background.common_pivot
}

local body_scale = 1020/1500

return element.make_new {
    cctr = function(self)
        self.rarity = self.rarity or RARITY.COMMON

        self.is_pivot_side = false

        self.other_side = sprite {
            image = rarity_background_pivot[self.rarity],
            position = dim2(0.5, 0, 0.5, 0),
            size = dim2(body_scale, 0, body_scale, 0),
            anchor = vec2.new(0.5, 0.5),
            color = color.new(1, 1, 1, 1),
            scaling = SCALING.CENTER
        }

        self._contents = {
            sprite { -- card body
                image = rarity_background_effect[self.rarity],
                position = dim2(0.5, 0, 0.5, 0),
                size = dim2(body_scale, 0, body_scale, 0),
                anchor = vec2.new(0.5, 0.5),
                color = color.new(1, 1, 1, 1),
                scaling = SCALING.CENTER
            },
            sprite { -- rarity accountrement
                image = rarity_accountrement[RARITY.EPIC],
                position = dim2(0, 0, 0, 0),
                size = dim2(1, 0, 1, 0),
                scaling = SCALING.CENTER,
            }
        }
    end,

    postcctr = function(self)
        local wrapper = button {
            children = self._contents,
            default_color = color.new(0, 0, 0, 0),
            hover_color = color.new(0, 0, 0, 0),
            click_color = color.new(0, 0, 0, 0),

            position = dim2(0, 0, 0, 0),
            size = dim2(1, 0, 1, 0),
            anchor = vec2.new(0, 0),

            on_click = {
                [2] = function()
                    self:turn()
                end
            }
        }

        self:add_child(wrapper)
        self.other_side.parent = wrapper
    end,

    base = {
        turn = function(self)
            local old_side = self._contents[1]
            self._contents[1] = self.other_side
            self.other_side = old_side
            self.is_pivot_side = not self.is_pivot_side
            self:recalc()
        end
    }
}
