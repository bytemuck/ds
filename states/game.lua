-- Auteurs : Jonas Lépine

local state = require("state")
local game = state.new("game")
local root = game.root

local options = require("states.options")
local transition = require("transition")
local flux = require("flux")

local dim2 = require("dim2")
local vec2 = require("vec2")
local group = require("group")
local sprite = require("sprite")
local button = require("button")
local frame = require("frame")
local color = require("color")
local constrain = require("constrain")
local text = require("text")
local ALIGN = require("ui.align")

local persistent = require("persistent")
local save  = require("save")

local card = require("ui.card.card")
local hand = require("ui.card.hand")
local tree = require("ui.card.tree")

local hostile = require("ui.hostile.hostile")
local profile = require("ui.profile.profile")
local random = require("random").new()

local SCALING = require("ui.scaling")

local assets = require("assets")

-- stuff in the game
local enemies = {
}

local hostile_group
local function layout_enemies(self)
    local total = 0
    local count = 0
    for _,v in ipairs(enemies) do
        if v.children[1] then
            count = count + 1
        end
    end
    local i = 0
    for _,v in ipairs(enemies) do
        v:recalc()
        if v.children[1] then
            i = i + 1
            total = total + v.children[1].abs_size.x
        end
        v.position = dim2((i-1)/count, 0, 0, 0)
    end

    self.abs_pos.x = (self.abs_size.x - total) / 2
    self.abs_size.x = total
end

local function create_card(id)
    return card { id = id, isTrue = false }
end

local function get_slots(tbl, tree)
    if tree.card.is_pivot_side then
        for i=1,tree.slots do
            local idx = i+1
            if tree.cards[idx] then
                get_slots(tbl, tree.children[idx])
            else
                tbl[#tbl+1] = tree.children[idx]
            end
        end
    end
    return tbl
end

local player_hand, play_tree
root.on_resize = function()
    player_hand.slots = get_slots({}, play_tree)
end

local function on_card_flip()
    root:recalc()
    player_hand.slots = get_slots({}, play_tree)
end

player_hand = hand {
    position = dim2(0.2, 0, 1.035, 0),
    size = dim2(0.8, 0, 0.05, 0),
    anchor = vec2.new(0, 1),
    slots = {},
    deck = {1, 1, 1},
    create_card = create_card,
    reset_slots = on_card_flip
}

local player_profile = profile {}

local function create_play_tree(root)
    play_tree = tree {
        card = card {
            id = 0,
            can_turn = false,
            is_pivot_side = true,
            show_text = true,
        },
        on_flip = on_card_flip
    }
end
create_play_tree()

local function create_hostile(add)
    local names = { "harry_potter", "goblin", "dragon_egg", "slime" } 

    local h = hostile {
        profile = player_profile,
        image = assets.sprites[names[random:nextRangeInt(1, #names + 1)]],
        size = dim2(0, 0, 1, 0),
        relayout = layout_enemies
    }

    if add then
        hostile_group:add_child(h)
        hostile_group:recalc()
    end

    return h
end

local function reset()
    player_profile:reset()

    player_hand:reset()
    save.shuffle_deck()
    player_hand:add_cards { create_card(save.draw_deck()), create_card(save.draw_deck()), create_card(save.draw_deck()), create_card(save.draw_deck()) }
    player_hand:do_recalc()

    play_tree.card = card {
        id = 0,
        can_turn = false,
        is_pivot_side = true,
        show_text = true,
    }

    on_card_flip()

    for i,_ in pairs(enemies) do
        enemies[i] = nil
    end

    create_hostile(true)
    create_hostile(true)
    create_hostile(true)
    create_hostile(true)
end

hostile_group = group {
    size = dim2(1, 0, 0.2, 0),
    on_recalc = layout_enemies,
    children = enemies
}

local player = profile {
    position = dim2(0, 4, 1, -4),
    size = dim2(0.25, 0, 0.25, 0),
    anchor = vec2.new(0, 1),
}

player.on_death = function()
    assets.audios.game:pause()
    transition(root, require("states.cardchoice"), 1)
end

local function target_enemy()
    for i,v in ipairs(enemies) do
        if not v.dead then
            return v
        end
    end
end

local collapsing = false
root:add_children {
    sprite {
        image = assets.sprites.background.game,
        scaling = SCALING.CENTER_OVERFLOW,
    },

    player,

    hostile_group,
    constrain {
        size = dim2(1, 0, 0.7, 0),
        position = dim2(0, 0, 0.15, 0),
        scaling = SCALING.CENTER,
        children = { play_tree }
    },
    player_hand,
    button {
        position = dim2(0, 16, 0.8, -16),
        size = dim2(0, 196, 0, 96),
        anchor = vec2.new(0, 1),
        hover_color = color.new(0, 0, 0, 0),
        click_color = color.new(0, 0, 0, 0),
        on_click = {
            [1] = function()
                if collapsing then return end

                local tbl = get_slots({}, play_tree)
                if #tbl == 0 then
                    collapsing = true
                    play_tree:collapse(function(values)
                        collapsing = false

                        player.defense = values[2]
                        player:recalc()

                        local won = false
                        local dmg = values[1]
                        while dmg > 0 do
                            local e = target_enemy()
                            if not e then
                                -- all enemies dead, transition to win screen
                                assets.audios.game:pause()
                                won = true
                                break
                            end

                            dmg = e:take_damage(dmg)
                        end

                        flux.to({t=0}, 0.5, {t=1}):oncomplete(function()
                            create_play_tree()
                            play_tree.parent = root
                            for i,v in ipairs(root.children) do
                                if v.children and #v.children == 1 and v.children[1][0].name == "tree" then
                                    local c = constrain {
                                        size = dim2(1, 0, 0.7, 0),
                                        position = dim2(0, 0, 0.15, 0),
                                        scaling = SCALING.CENTER,
                                        children = { play_tree }
                                    }
                                    c.parent = root
                                    root.children[i] = c
                                end
                            end

                            root:recalc()
                            play_tree:reset()
                            root:recalc()
                            on_card_flip()
                            root:recalc()

                            if won then
                                persistent.level = persistent.level + 1
                                transition(root, nil, 1)
                                collapsing = false
                            else
                                local a = flux.to({t=0}, 0.5, {t=1})

                                for _,v in pairs(enemies) do
                                    if not v.dead then
                                        local p = v.position
                                        a = a:after(p, 0.1, {yo=20}):ease("circout"):oncomplete(function()
                                            v:play_turn(player)
                                        end):after(p, 0.1, {yo=0}):ease("circin")
                                    end
                                end

                                a:after({t=0}, 0.2, {t=1}):oncomplete(function()
                                    player.defense = 0
                                    player:recalc()
                                    collapsing = false
                                end)
                            end
                        end)
                    end)
                else
                    for _,v in pairs(tbl) do
                        local c = v.children[1].color
                        local c1 = color.new(0, 0, 0, 0.8)
                        local c2 = color.new(1, 0.1, 0.1, 0.9)
                        flux.to(c, 0.2, c2):ease("circout")
                            :after(c, 0.4, c1):ease("circin")
                    end
                end
            end
        },

        children = {
            sprite {
                position = dim2(0, 0, 0, 0),
                size = dim2(1, 0, 1, 0),
                anchor = vec2.new(0, 0),
                image = assets.sprites.fight_button,
            },
            text {
                position = dim2(0, 72, 0.5, 0),
                font = assets.fonts.roboto[30],
                text = "Attaquer",
                y_align = ALIGN.CENTER_Y,
            },
        }
    }
}

game.start = function()
    assets.audios.game:play()
    player.health = 10
    reset()
    on_card_flip()
end

return game
