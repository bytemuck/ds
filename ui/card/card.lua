local element = require("element")
local color = require("color")
local assets = require("assets")

local sprite = require("sprite")
local group = require("group")
local button = require("button")

local SCALING = require("ui.scaling")

local RARITY = require("rarity")

local rarity_sprites = {
    [RARITY.COMMON] = assets.sprites.squirrel
}

return element.make_new {
    cctr = function(self)
        self.rarity = self.rarity or RARITY.COMMON

        self.other_side = group {}

        self._contents = {
            sprite { -- rarity accountrement
                image = rarity_sprites[self.rarity]
            },
            sprite { -- card body
                image = assets.sprites.squirrel
            },
            group {}
        }
    end,

    postcctr = function(self)
        self:add_children {
            button {
                children = self._contents,
                default_color = color.new(0, 0, 0, 0),
                hover_color = color.new(0, 0, 0, 0),
                click_color = color.new(0, 0, 0, 0),

                on_click = {
                    [2] = function()
                        self:turn()
                    end
                }
            }
        }
    end,

    base = {
        turn = function(self)
            local old_side = self._contents[#self._contents]
            self._contents[#self._contents] = self.other_side
            self.other_side = old_side
        end
    }
}
