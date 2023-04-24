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

local tree; tree = element.make_new {
    name = "tree",

    cctr = function(self)
        local c = constrain {
            children = { self.card or error("no tree card") },
            ratio = CARD_ASPECT_RATIO,
            scaling = SCALING.CENTER,
        }

        self.slots = 1
        self.depth = 1

        self.main = c
        self.children = { c }
        self.cards = {}
    end,

    postcctr = function(self)
        self.card.on_flip = function()
            self:recalc()
            self.on_flip()
        end
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
                local maxdepth = 1
                local breadth = 0

                for i=1,self.slots do
                    local e = self.cards[i+1]
                    breadth = breadth + (e and e.breadth or 1)
                end

                for i=1,self.slots do
                    local idx = i+1
                    local e = self.cards[idx]

                    if e then
                        maxdepth = math.max(maxdepth, e.depth)
                    else
                        e = group {
                            idx = idx,
                            children = {
                                sprite {
                                    size = dim2(0.5, 0, 0.5, 0),
                                    position = dim2(0.5, 0, 0.5, 0),
                                    anchor = vec2.new(0.5, 0.5),
                                    color = color.new(0, 0, 0, 0.8),

                                    image = assets.sprites.circle,
                                    scaling = SCALING.CENTER
                                }
                            }
                        }
                    end

                    e.size = dim2((e.breadth or 1)/breadth, 0, 1, 0)
                    e.position = dim2((i-1)/self.slots, 0, 0.9, 0)

                    self.children[idx] = e
                    e.parent = self
                end

                self.breadth = breadth
                self.depth = 1 + maxdepth
                self.constrain_mult = vec2.new(1, self.depth)
            else
                for i,_ in ipairs(self.children) do
                    if i ~= 1 then
                        self.children[i] = nil
                    end
                end
                self.breadth = 1
                self.depth = 1
                self.constrain_mult = vec2.new(1, 1)
            end
        end,

        fill_slot = function(self, idx, card)
            -- you cannot turn a pivot card which has a filled slot back to the effect side
            self.card.can_turn = false

            self.cards[idx] = tree {
                card = card,
                on_flip = self.on_flip
            }
        end
    }
}

return tree
