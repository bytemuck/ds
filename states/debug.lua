local state = require("state")
local debug = state.new("debug")
local root = debug.root

local dim2 = require("dim2")
local vec2 = require("vec2")
local group = require("group")
local sprite = require("sprite")
local hostile = require("ui.hostile.hostile")
local profile = require("ui.profile.profile")
local button = require("button")
local frame = require("frame")
local color = require("color")

local SCALING = require("ui.scaling")

local assets = require("assets")

root:add_children {
    profile {},
    hostile {
        image = assets.sprites.harry_potter,
        position = dim2(0.2, 0, 0.2, 0),
        anchor = vec2.new(0.5, 0.5),
        size = dim2(0.2, 0, 0.2, 0),
    },
    hostile {
        image = assets.sprites.harry_potter,
        position = dim2(0.5, 0, 0.2, 0),
        anchor = vec2.new(0.5, 0.5),
        size = dim2(0.2, 0, 0.2, 0),
    },
    hostile {
        image = assets.sprites.harry_potter,
        position = dim2(0.8, 0, 0.2, 0),
        anchor = vec2.new(0.5, 0.5),
        size = dim2(0.2, 0, 0.2, 0),
    }
}

return debug
