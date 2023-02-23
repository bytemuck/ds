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

local assets = require("assets")

root:add_children {
    frame {
        color = color.new(1, 0, 0, 1),
        position = dim2(0.5, 0, 0.5, 0),
        size = dim2(1, 0, 1, 0),
        anchor = vec2.new(0.5, 0.5),

        children = {
            group {
                position = dim2(0.5, 0, 0.5, 0),
                size = dim2(1, -4, 1, -4),
                anchor = vec2.new(0.5, 0.5),

                children = {
                    button {
                        position = dim2(0, 0, 0, 0),
                        size = dim2(0.5, 0, 1, 0),
                        anchor = vec2.new(0, 0),
                        on_click = {
                            [1] = function()
                                transition(root, options, 1)
                            end
                        },

                        children = {
                            sprite {
                                image = assets.sprites.squirrel
                            }
                        }
                    },
                    sprite {
                        image = assets.sprites.monkey,
                        position = dim2(1, 0, 0, 0),
                        size = dim2(0.5, 0, 1, 0),
                        anchor = vec2.new(1, 0)
                    }
                }
            }
        }
    }
}

return debug
