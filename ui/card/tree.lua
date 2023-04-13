local element = require("element")
local color = require("color")
local dim2 = require("dim2")
local vec2 = require("vec2")
local assets = require("assets")

local sprite = require("sprite")
local group = require("group")
local button = require("button")
local constrain = require("constrain")
local SCALING = require("ui.scaling")

local CARD_ASPECT_RATIO = 1.4

local flux = require("flux")

return element.make_new {
    cctr = function(self)
        local c = constrain {
            children = { self.card or error("no tree card") },
            ratio = CARD_ASPECT_RATIO,
            scaling = SCALING.CENTER,
        }

        self.slots = 1

        self.main = c
        self.children = { c }
        self.cards = {}
    end,

    postcctr = function(self)
        self:reset()
    end,

    on_recalc = function(self)
        self:do_recalc()
    end,

    base = {
        reset = function(self)
            self.slots = self.card.pivot.slots
            self:recalc()
        end,

        do_recalc = function(self)
            if self.card.is_pivot_side then
                for i=1,self.slots do
                    local idx = i+1
                    local e = self.cards[idx] or button {
                        children = {
                            sprite {
                                image = assets.sprites.circle
                            }
                        }
                    }

                    -- e.size/e.pos

                    self.children[idx] = e
                end
            else
                for i,v in ipairs(self.children) do
                    if i ~= 1 then
                        --v:destroy()
                    end
                end
            end
        end,

        fill_slot = function(self, idx)
            return function(card)
                -- you cannot turn a pivot card which has a filled slot back to the effect side
                self.card.can_turn = false

                -- todo: remove card from hand
                self.filled = self.filled + 1
                self.cards[idx] = card

                self:recalc()
            end
        end
    }
}
