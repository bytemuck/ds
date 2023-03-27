local state = require("state")
local debug = state.new("debug")
local root = debug.root

local options = require("states.options")
local transition = require("transition")

local dim2 = require("dim2")
local vec2 = require("vec2")
local group = require("group")
local sprite = require("sprite")
local button = require("button")
local frame = require("frame")
local color = require("color")

local card = require("ui.card.card")
local hand = require("ui.card.hand")

local SCALING = require("ui.scaling")

local assets = require("assets")

-- stuff in the game
local enemies = {}

local player_hand = hand {
    position = dim2(0.3, 0, 1, 0),
    size = dim2(0.6, 0, 0.15, 0),
    anchor = vec2.new(0, 1)
}

player_hand:add_cards { card {}, card {}, card {}, card {} }

local function reset()
    enemies = {}
    player_hand:reset()
end

local function on_card_flip()
    -- check if all leaves are effect side
end

root:add_children {
    frame {},
    player_hand
}

player_hand:do_recalc()

return debug
