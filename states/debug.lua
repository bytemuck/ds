local state = require("state")
local debug = state.new()
local root = debug.root

local options = require("states.options")

local dim2 = require("ui.dim2")
local vec2 = require("ui.vec2")
local group = require("ui.group")
local sprite = require("ui.sprite")
local button = require("ui.button")
local frame = require("ui.frame")
local color = require("ui.color")

local assets = require("assets")

root:add_children {
    frame {
        color = color.new(1, 0, 0, 1),
        position = dim2(0.5, 0, 0.5, 0),
        size = dim2(0.98, 0, 0.98, 0),
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

                        on_click = function()
                            print("clicked")
                            state.push(options)
                        end,

                        children = {
                            sprite {
                                image = assets.sprites.squirrel,
                                position = dim2(0, 0, 0, 0),
                                size = dim2(1, 0, 1, 0),
                            },
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
