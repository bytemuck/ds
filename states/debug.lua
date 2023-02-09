local state = require("state").new()
local root = state.root

local dim2 = require("ui.dim2")
local vec2 = require("ui.vec2")
local group = require("ui.group")
local sprite = require("ui.sprite")
local frame = require("ui.frame")
local color = require("ui.color")

local assets = require("asset_loader")

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
                    sprite {
                        image = assets["sprite/squirrel"],
                        position = dim2(0, 0, 0, 0),
                        size = dim2(0.5, 0, 1, 0),
                        anchor = vec2.new(0, 0)
                    },
                    sprite {
                        image = assets["sprite/monkey"],
                        position = dim2(1, 0, 0, 0),
                        size = dim2(0.5, 0, 1, 0),
                        anchor = vec2.new(1, 0)
                    }
                }
            }
        }
    }
}

return state
