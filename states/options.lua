local state = require("state")
local options = state.new()
local root = options.root

local transition = require("transition")

local dim2 = require("ui.dim2")
local vec2 = require("ui.vec2")
local group = require("ui.group")
local sprite = require("ui.sprite")
local button = require("ui.button")
local frame = require("ui.frame")
local color = require("ui.color")

local assets = require("assets")

root:add_children {
    button {
        position = dim2(0.5, 0, 0.5, 0),
        size = dim2(0.98, 0, 0.98, 0),
        anchor = vec2.new(0.5, 0.5),

        on_click = function()
            transition(root, state.pop(), 1)
        end,

        children = {
            frame {
                color = color.new(1, 0, 0, 1),
            }
        }
    }
}

return options
