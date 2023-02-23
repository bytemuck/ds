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

root.before_draw = function ()
    local under = state.stack[#state.stack - 1];
    if under then under.root:draw() end
end

root:add_children {
    frame {
        position = dim2(0, 0, 0, 0),
        size = dim2(1, 0, 1, 0),
        color = color.new(0.2, 0.2, 0.2, 0.8),

        children = {
            button {
                position = dim2(0.5, 0, 0.5, 0),
                size = dim2(0.75, 0, 0.75, 0),
                anchor = vec2.new(0.5, 0.5),
        
                on_click = {
                    -- left button
                    [1] = function()
                        transition(root, nil, 1)
                    end,
                    -- right button
                    [2] = function ()
                        -- do nothing
                    end
                },
        
                children = {
                    frame {
                        color = color.new(1, 0, 0, 1),
                    }
                }
            }
        }
    }
}

return options
