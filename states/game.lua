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
    hostile {
        image = assets.sprites.harry_potter,
    },
    hostile {
        image = assets.sprites.harry_potter,
    },
    hostile {
        image = assets.sprites.harry_potter,
    }
}

local function layout_enemies(self)
    local total = 0
    for _,v in ipairs(enemies) do
        v:recalc()
        total = total + v.abs_size.x
    end
    for _,v in ipairs(enemies) do
        v:recalc()
        total = total + v.abs_size.x
    end

    self.abs_size.x = total
end

local player_hand = hand {
    position = dim2(0.25, 0, 1, 0),
    size = dim2(0.75, 0, 0.15, 0),
    anchor = vec2.new(0, 1)
}

local player_profile = profile {}

local function on_card_flip()
    -- check if all leaves are effect side
end

local function create_card(id)
    return card {
        id = id,
        on_flip = on_card_flip
    }
end

local function create_hostile(type)
    return hostile {
        profile = player_profile
    }
end

local function reset()
    player_hand:reset()
    player_profile:reset()

    for i,_ in pairs(enemies) do
        enemies[i] = nil
    end
end

player_hand:add_cards { create_card(1), create_card(1), create_card(1), create_card(1) }

root:add_children {
    frame {}, -- temp: background

    profile {
        position = dim2(0, 0, 1, 0),
        size = dim2(0.25, 0, 0.25, 0),
        anchor = vec2.new(0, 1),
    },

    player_hand,

    constrain {
        scaling = SCALING.CENTER,
        position = dim2(0, 0, 0, 0),
        size = dim2(1, 0, 0.5, 0),
        anchor = vec2.new(0, 0),

        children = {
            group {
                on_recalc = layout_enemies,
                children = enemies
            }
        }
    },

    constrain {
        ratio = 1,
        scaling = SCALING.CENTER,
        position = dim2(0.5, 0, 0.5, 0),
        size = dim2(0.5, 0, 0.5, 0),
        anchor = vec2.new(0.5, 0.5),

        children = {
            --
        }
    }
}

player_hand:do_recalc()

return debug
