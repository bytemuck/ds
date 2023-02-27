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

local sprite = require("sprite")

local assets = require("assets")

local random = require("random")

local function gen()
    local LEVEL_COUNT = 5

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
        group {},
    }

    local s = {}
    local e = { [1] = 0,[2] = random(0.1, 0.9) }

    for i = 1, LEVEL_COUNT do
        s = e
        e = { [1] = i * (1 / LEVEL_COUNT),[2] = random(0.1, 0.9) }

        root.children[3]:add_children {
            line {
                position = dim2(s[1], 0, s[2], 0),
                size = dim2(e[1], 0, e[2], 0),
                color = color.new(love.math.random(), love.math.random(), love.math.random(), 1),
            }
        }

        root.children[4]:add_children {
            button {
                position = dim2(e[1], 0, e[2], 0),
                size = dim2(0.0, 32, 0.0, 32),
                anchor = vec2.new(0.5, 0.5),

                on_click = {
                    [1] = function()
                        print("pressed level " .. i)
                    end,
                },

                children = {
                    frame {
                        color = color.new(1, 0, 0, 1),
                    }
                }
            }
        }
    end
end

gen()
return progression
