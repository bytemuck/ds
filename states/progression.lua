local state = require("state")
local progression = state.new("debug")
local root = progression.root

local dim2 = require("dim2")
local vec2 = require("vec2")

local SCALING = require("ui.scaling")

local group = require("group")

local button = require("button")
local frame = require("frame")
local color = require("color")
local line = require("line")

local anim = require("anim")
local sprite = require("sprite")
local text = require("text")

local assets = require("assets")

local random = require("random")

local ALIGN = require("ui.align")

local flux = require("flux")

local function gen()
    local LEVEL_COUNT = 5

    local s = {}
    local e = { [1] = 0.1,[2] = random(0.1, 0.9) }

    root:add_children {
        sprite {
            image = assets.sprites.progression,
            position = dim2(0, 0, 0, 0),
            size = dim2(1, 0, 1, 0),
            scaling = SCALING.STRETCH,
        },

        button {
            position = dim2(1, 0, 0, 0),
            size = dim2(0.0, 48, 0.0, 48),
            anchor = vec2.new(1, 0),
            hover_color = color.new(0.5, 0, 0, 0.4),
            click_color = color.new(0.7, 0, 0, 0.6),

            on_click = {
                [1] = function()
                    root:clear_children()
                    gen()
                end,
            },

            children = {
                sprite {
                    image = assets.sprites.x_button,
                    position = dim2(0, 0, 0, 0),
                    size = dim2(1, 0, 1, 0),
                    scaling = SCALING.CENTER,
                },
            }
        },
        group {},
        group {
            children = {}
        },
        text {
            color = color.new(0, 1, 0, 1),
            text = "THE TITLE\nAND A SUBTITLE\nAND ANOTHER\n\n\n",
            position = dim2(0.5, 0, 0.5, 0),
            font = assets.fonts.roboto[42],
            x_align = ALIGN.CENTER_X,
            y_align = ALIGN.CENTER_Y,
        },

        sprite {
            image = assets.sprites.spirit,
            position = dim2(e[1], 0, e[2], 0),
            size = dim2(0, 32, 0, 32),
            anchor = vec2.new(0.5, 0.5),
            scaling = SCALING.CENTER,
        },

        anim {
            animation = assets.animations.monkey_idle,
        }
    }

    local function add()
        local n = #root.children[4]
        local thing; thing = button {
            position = dim2(e[1], 0, e[2], 0),
            size = dim2(0.0, 32, 0.0, 32),
            anchor = vec2.new(0.5, 0.5),

            on_click = {
                [1] = function()
                    print("pressed level " .. n)
                    flux.to(root.children[6].position, 1, thing.position.vals)
                end,
            },

            children = {
                frame {
                    color = color.new(1, 0, 0, 1),
                }
            }
        }

        root.children[4]:add_child(thing)
    end

    add()
    for i = 1, LEVEL_COUNT do
        s = e
        e = { [1] = 0.1 + (i / LEVEL_COUNT) * 0.8,[2] = random(0.1, 0.9) }

        root.children[3]:add_children {
            line {
                position = dim2(s[1], 0, s[2], 0),
                size = dim2(e[1], 0, e[2], 0),
                color = color.new(love.math.random(), love.math.random(), love.math.random(), 1),
            }
        }

        add()
    end
end

gen()
return progression
