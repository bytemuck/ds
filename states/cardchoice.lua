local state = require("state")
local cardchoice = state.new("cardchoice")
local root = cardchoice.root

local transition = require("transition")
local SCALING = require("ui.scaling")
local FLIPMODE = require("ui.flipmode")
local ALIGN = require("ui.align")

local assets = require("assets")

local frame = require("frame")
local button = require("button")
local color = require("color")
local dim2 = require("dim2")
local vec2 = require("vec2")
local text = require("text")
local sprite = require("sprite")

local card = require("ui.card.card")

local save = require("save")
local cards = require("persistent.cards")

-- card.children[1].on_click = function() end

local c1 = card {
    id = cards.next(),
    position = dim2(0.2, 0, 0.5, 0),
    size = dim2(0.25, 0, 0.3, 0),
    anchor = vec2.new(0.5, 0.5),
}

c1.children[1].on_click[1] = function()
    state.pop()
    save.push(c1.id)
end

local c2 = card {
    id = cards.next(),
    position = dim2(0.5, 0, 0.5, 0),
    size = dim2(0.25, 0, 0.3, 0),
    anchor = vec2.new(0.5, 0.5),
}

c2.children[1].on_click[1] = function()
    state.pop()
    save.push(c2.id)
end

local c3 = card {
    id = cards.next(),
    position = dim2(0.8, 0, 0.5, 0),
    size = dim2(0.25, 0, 0.3, 0),
    anchor = vec2.new(0.5, 0.5),
}

c3.children[1].on_click[1] = function()
    state.pop()
    save.push(c3.id)
end

root:add_children {
    sprite {
        image = assets.sprites.game,
        position = dim2(0, 0, 0, 0),
        size = dim2(1, 0, 1, 0),
        scaling = SCALING.CENTER_OVERFLOW,

        children = {
            frame {
                position = dim2(0.5, 0, 0.17, 0),
                size = dim2(0.65, 0, 0.3, 0),
                anchor = vec2.new(0.5, 0.5),
                color = color.new(1, 1, 1, 0.5),
                scaling = SCALING.CENTER,
            },
            text {
                position = dim2(0.5, 0, 0.1, 0),
                text = "YOU LOST",
                font = assets.fonts.roboto[100],
                x_align = ALIGN.CENTER_X,
                y_align = ALIGN.CENTER_Y,
                color = color.new(0, 0, 0, 1),
            },
            text {
                position = dim2(0.5, 0, 0.25, 0),
                text = "choose a card",
                font = assets.fonts.roboto[100],
                x_align = ALIGN.CENTER_X,
                y_align = ALIGN.CENTER_Y,
                color = color.new(0, 0, 0, 1),
            },
            c1,
            c2,
            c3,
            sprite {
                image = assets.sprites.sword_button,
                position = dim2(0.8, 0, 0.9, 0),
                size = dim2(0.4, 0, 0.1, 0),
                anchor = vec2.new(0.5, 0.5),
                scaling = SCALING.CENTER,

                children = {
                    button {
                        position = dim2(0.5, 0, 0.5, 0),
                        size = dim2(0.7, 0, 1, 0),
                        anchor = vec2.new(0.5, 0.5),

                        on_click = {
                            -- left button
                            [1] = function()
                                transition(root, require("states.progression"), 1)
                            end,


                        },
                    },
                    text {
                        position = dim2(0.5, 0, 0.5, -8),
                        text = "Skip",
                        font = assets.fonts.roboto[42],
                        x_align = ALIGN.CENTER_X,
                        y_align = ALIGN.CENTER_Y,
                        color = color.new(0, 0, 0, 1),
                    }
                }
            },
        }
    }

}



return cardchoice
