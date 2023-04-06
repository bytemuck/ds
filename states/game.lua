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
local constrain = require("constrain")

local card = require("ui.card.card")
local hand = require("ui.card.hand")

local hostile = require("ui.hostile.hostile")
local profile = require("ui.profile.profile")

local SCALING = require("ui.scaling")

local assets = require("assets")

-- stuff in the game
local enemies = {
}

local hostile_constraint, hostile_group
local function layout_enemies(self)
    local total = 0
    for _,v in ipairs(enemies) do
        v:recalc()
        v.position = dim2(0, total, 0, 0)
        total = total + v.children[1].abs_size.x
    end

    self.abs_size.x = total
    hostile_constraint:constrain(true)
end

local player_hand = hand {
    position = dim2(0.25, 0, 1, 0),
    size = dim2(0.75, 0, 0.15, 0),
    anchor = vec2.new(0, 1)
}

local player_profile = profile {}

local function on_card_flip(card)
    -- check if all leaves are effect side
end

local function create_card(id)
    return card {
        id = id,
        on_flip = on_card_flip
    }
end

local function create_hostile(type, add)
    local h = hostile {
        profile = player_profile,
        image = assets.sprites.harry_potter,
        size = dim2(0, 0, 1, 0)
    }

    if add then
        hostile_group:add_child(h)
        hostile_constraint:recalc()
    end

    return h
end

local function reset()
    player_hand:reset()
    player_profile:reset()

    for i,_ in pairs(enemies) do
        enemies[i] = nil
    end
end

player_hand:add_cards { create_card(1), create_card(1), create_card(1), create_card(1) }

hostile_group = group {
    on_recalc = layout_enemies,
    children = enemies
}

hostile_constraint = constrain {
    scaling = SCALING.CENTER,
    position = dim2(0, 0, 0, 0),
    size = dim2(1, 0, 0.3, 0),
    anchor = vec2.new(0, 0)
}

create_hostile(1, true)
create_hostile(1, true)

hostile_constraint:add_child(hostile_group)

create_hostile(1, true)
create_hostile(1, true)

root:add_children {
    frame {}, -- temp: background

    profile {
        position = dim2(0, 0, 1, 0),
        size = dim2(0.25, 0, 0.25, 0),
        anchor = vec2.new(0, 1),
    },

    player_hand,
    hostile_constraint,

    --[[constrain {
        ratio = 1,
        scaling = SCALING.CENTER,
        position = dim2(0.5, 0, 0.5, 0),
        size = dim2(0.5, 0, 0.5, 0),
        anchor = vec2.new(0.5, 0.5),

        children = {
            -- TREE
        }
    }]]
}

player_hand:do_recalc()

return debug
