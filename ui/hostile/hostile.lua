local element = require("element")
local sprite = require("sprite")

local text = require("text")
local button = require("button")

local SCALING = require("ui.scaling")
local ALIGN = require("ui.align")

local INTENTION = require("intention")

local dim2 = require("dim2")
local vec2 = require("vec2")
local color = require("color")

local assets = require("assets")


return element.make_new {
    cctr = function(self)
        self.health = self.health or 3
        self.intention = self.intention or INTENTION.ATTACK -- do damage to player
        self.intention_value = self.intention_value or 3 -- 3 damage
        self._intern = {}
    end,

    postcctr = function(self)
        self._intern.health_text = text {
            text = tostring(self.health),
            position = dim2(0.5, 0, 0.5, 0), -- center
        
            font = assets.fonts.roboto[36],
        
            x_align = ALIGN.CENTER_X,
            y_align = ALIGN.CENTER_Y,
        }

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
                    self._intern.health_text
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

    base = {
        take_damage = function(self, damage)
            self.health = self.health - damage
            if self.health < 0 then
                -- die
            end
            
            self._intern.health_text = tostring(self.health)
        end,
        die = function(self)
            -- die
        end,
        generate_turn = function(self)
            self.intention = INTENTION.ATTACK -- we should generate and intention
            self.intention_value = 3 -- should be a generated object used by intention        
        end,
        play_turn = function(self, player)
            if self.intention == INTENTION.ATTACK then
                player.take_damage(self.intention_value)
            end
        end,
    }
}