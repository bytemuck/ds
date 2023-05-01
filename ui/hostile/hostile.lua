local element = require("element")
local sprite = require("sprite")

local text = require("text")
local button = require("button")
local group = require("group")
local constrain = require("constrain")

local SCALING = require("ui.scaling")
local ALIGN = require("ui.align")

local INTENTION = require("intention")

local dim2 = require("dim2")
local vec2 = require("vec2")
local color = require("color")

local assets = require("assets")

local flux = require("flux")
local random = require("random").new()

return element.make_new {
    name = "hostile",

    cctr = function(self)
        self.health = self.health or random:nextRangeInt(1, 5)
        self.intention = self.intention or INTENTION.ATTACK -- do damage to player
        self.intention_value = self.intention_value or random:nextRangeInt(1, 5)    -- 3 damage
    end,

    postcctr = function(self)
        self.health_text = text {
            text = tostring(self.health),
            position = dim2(0.5, 0, 0.5, 4), -- center

            font = assets.fonts.roboto[28],

            x_align = ALIGN.CENTER_X,
            y_align = ALIGN.CENTER_Y,
        }

        self.intention_text = text {
            text = tostring(self.intention_value),
            position = dim2(0.5, 0, 0.5, -4), -- center

            font = assets.fonts.roboto[28],
            color = color.new(1, 1, 0.3, 1.0),
            x_align = ALIGN.CENTER_X,
            y_align = ALIGN.CENTER_Y,
        }

        self:add_children {
            constrain {
                ratio = 1,
                scaling = SCALING.OVERFLOW_RIGHT,

                children = {
                    group { children = {
                        sprite {
                            size = dim2(1, -32, 1, -32),
                            position = dim2(0, 16, 0, 32),
                            image = self.image,
                            scaling = SCALING.CENTER
                        },
                        sprite {
                            image = assets.sprites.heart,
                            position = dim2(0, 0, 1, 0), -- bottom left
                            size = dim2(0, 52, 0, 52),   -- 32px 32px
                            anchor = vec2.new(0, 1),     -- bottom left
                            children = {
                                self.health_text
                            },
                        },
                        sprite {
                            image = assets.sprites.attack,
                            position = dim2(1, 0, 1, 24), -- bottom right
                            size = dim2(0, 80, 0, 80),   -- 32px 32px
                            anchor = vec2.new(1, 1),     -- bottom right
                            children = {
                                self.intention_text
                            },
                        },
                        sprite {
                            image = assets.sprites.x_button,
                            position = dim2(0.5, 0, 0, 0), -- top center
                            size = dim2(0, 32, 0, 32),     -- 32px 32px
                            anchor = vec2.new(0.5, 0),     -- bottom left
                        },
                    } }
                }
            }
        }
    end,

    base = {
        take_damage = function(self, damage)
            self.health = self.health - damage
            if self.health <= 0 then
                self:die()
            end

            self.health_text.text_objs = self.health_text.update_text(tostring(self.health))
        end,
        die = function(self)
            flux.to(self.children[1].children[1].size, 0.5, dim2(0, 0, 0, 0).vals):ease("circout"):oncomplete(function()
                self.children = {}
                self.parent:recalc()
            end)
        end,
        generate_turn = function(self)
            self.intention = INTENTION.ATTACK -- we should generate and intention
            self.intention_value = random:nextRangeInt(1, 5)          -- should be a generated object used by intention
            self.intention_text.text_objs = self.intention_text.update_text(tostring(self.intention_value))
        end,
        play_turn = function(self, player)
            if self.intention == INTENTION.ATTACK then
                player:take_damage(self.intention_value)
            end
        end,
    }
}
