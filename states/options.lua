local state = require("state")
local options = state.new("options")
local root = options.root

local transition = require("transition")

local SCALING = require("ui.scaling")
local ALIGN = require("ui.align")
local text = require("text")

local dim2 = require("dim2")
local vec2 = require("vec2")
local group = require("group")
local sprite = require("sprite")
local button = require("button")
local frame = require("frame")
local color = require("color")


local assets = require("assets")

local volume = 1
local text_volume = text {
    position = dim2(0.5, 0, 0.3, 0),
    text = volume,
    font = assets.fonts.roboto[32],
    x_align = ALIGN.CENTER_X,
    y_align = ALIGN.CENTER_Y,
    color = color.new(1, 1, 1, 1),
}

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
                position = dim2(0.25, 0, 0.5, 0),
                size = dim2(0.25, 0, 0.25, 0),
                anchor = vec2.new(0.5, 0.5),

                on_click = {
                    -- left button
                    [1] = function()
                        volume = volume + 0.1
                        if volume > 1 then
                            volume = 1
                        end
                        text_volume.text_objs = text_volume.update_text(tostring(volume))
                        assets.audios.progression_map:setVolume(volume)
                        assets.audios.startmenu:setVolume(volume)
                    end,
                        
                    
                },

                children = {
                    frame {
                        color = color.new(1, 0, 0, 1),
                    },
                    text {
                        position = dim2(0.5, 0, 0.5, 0),
                        text = "Augmenter",
                        font = assets.fonts.roboto[42],
                        x_align = ALIGN.CENTER_X,
                        y_align = ALIGN.CENTER_Y,
                        color = color.new(0, 0, 0, 1),
                    },
                
                },
            },
            button {
                position = dim2(0.75, 0, 0.5, 0),
                size = dim2(0.25, 0, 0.25, 0),
                anchor = vec2.new(0.5, 0.5),

                on_click = {
                    -- left button
                    [1] = function()
                        volume = volume - 0.1
                        if volume < 0.1 then
                            volume = 0
                        end
                        text_volume.text_objs = text_volume.update_text(tostring(volume))
                        assets.audios.progression_map:setVolume(volume)
                        assets.audios.startmenu:setVolume(volume)
                    end,
                        
                    
                },

                children = {
                    frame {
                        color = color.new(1, 0, 0, 1),
                    },
                    text {
                        position = dim2(0.5, 0, 0.5, 0),
                        text = "Diminuer",
                        font = assets.fonts.roboto[42],
                        x_align = ALIGN.CENTER_X,
                        y_align = ALIGN.CENTER_Y,
                        color = color.new(0, 0, 0, 1),
                    },
                }
            },
            button {
                position = dim2(1, 0, 0, 0),
                size = dim2(0.0, 48, 0.0, 48),
                anchor = vec2.new(1, 0),
                hover_color = color.new(0.5, 0, 0, 0.4),
                click_color = color.new(0.7, 0, 0, 0.6),
    
                on_click = {
                    [1] = function()
                        transition(root, nil, 1)
                        
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
            text {
                position = dim2(0.5, 0, 0.2, 0),
                text = "Volume",
                font = assets.fonts.roboto[100],
                x_align = ALIGN.CENTER_X,
                y_align = ALIGN.CENTER_Y,
                color = color.new(1, 1, 1, 1),
            },
            text_volume,
        }
    }
}

return options
