local state = require("state")
local options = state.new("options")
local root = options.root

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
    button {
        position = dim2(0.5, 0, 0.5, 0),
        size = dim2(0.98, 0, 0.98, 0),
        anchor = vec2.new(0.5, 0.5),

        on_click = function()
            transition(root, nil, 1)
        end,

        children = {
            frame {
                color = color.new(1, 0, 0, 1),
            }
        }
    }
}

return options
