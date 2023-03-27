local element = require("element")
local color = require("color")
local dim2 = require("dim2")
local vec2 = require("vec2")
local assets = require("assets")

local sprite = require("sprite")
local group = require("group")
local button = require("button")

local HAND_MOVE_TIME = 0.25
local HAND_EASING = "circout"

local flux = require("flux")

return element.make_new {
    cctr = function(self)

    end,

    on_recalc = function(self)
        self:do_recalc()
    end,

    base = {
        reset = function(self)
            self.cards = {}
            self:recalc()
        end,

        do_recalc = function(self)
        end,

        add_cards = function(self, cards)
        end
    }
}