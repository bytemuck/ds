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

local function gen()
    local LEVEL_COUNT = 5

    root:add_children {
        button {
            position = dim2(0, 0, 0, 0),
            size = dim2(0.1, 0, 0.1, 0),
    
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
                    scaling = SCALING.CENTER
                }
            }
        }
    }

    local s = {}
    local e = { [1] = 0, [2] = (love.math.random() + 0.1) * (0.9 / 1.1) }

    for i = 1, LEVEL_COUNT do
        s = e
        e = { [1] = i * (1 / LEVEL_COUNT), [2] = (love.math.random() + 0.1) * (0.9 / 1.1) }

        root:add_children {
            line {
                position = dim2(s[1], 0, s[2], 0),
                size = dim2(e[1], 0, e[2], 0),
                color = color.new(love.math.random(), love.math.random(), love.math.random(), 1),
            }
        }
    end
end

gen()
return progression
