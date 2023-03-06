local state = require("state")
local startmenu = state.new("startmenu")
local root = startmenu.root

local transition = require("transition")

local SCALING = require("ui.scaling")
local FLIPMODE = require("ui.flipmode")
local ALIGN = require("ui.align")

local frame = require("frame")
local dim2 = require("dim2")
local color = require("color")
local vec2 = require("vec2")
local button = require("button")
local sprite = require("sprite")
local text = require("text")

local assets = require("assets")

root:add_children{
    frame {
        position = dim2(0, 0, 0, 0),
        size = dim2(1, 0, 1, 0),
        color = color.new(0.2, 0.2, 0.2, 0.8),

        children = {
            sprite {
                image = assets.sprites.sword_button,
                position = dim2(0.5, 0, 0.5, 0),
                size = dim2(0.5, 0, 0.1, 0),
                anchor = vec2.new(0.5, 0.5),
                scaling = SCALING.CENTER,

                children = {
                    button {
                        position = dim2(0.5, 0, 0.5, 0),
                        size = dim2(0.7, 0, 1, 0),
                        anchor = vec2.new(0.5, 0.5),
                        
                        on_click = {
                            -- left button
                            [1] = function()
                                transition(root, require("states.progression"), 1)
                            end,
                            
                            
                        },
                    },
                    text {
                        position = dim2(0.5, 0, 0.5, -8),
                        text = "Play",
                        x_align = ALIGN.CENTER_X,
                        y_align = ALIGN.CENTER_Y,
                    }  
                }
            },
            sprite {
                image = assets.sprites.sword_button,
                position = dim2(0.5, 0, 0.65, 0),
                size = dim2(0.5, 0, 0.1, 0),
                anchor = vec2.new(0.5, 0.5),
                scaling = SCALING.CENTER,
                flip = FLIPMODE.FLIP_XY,
            

                children = {
                    button {
                        position = dim2(0.5, 0, 0.5, 0),
                        size = dim2(0.7, 0, 1, 0),
                        anchor = vec2.new(0.5, 0.5),
                        
                        on_click = {
                            -- left button
                            [1] = function()
                                transition(root, require("states.options"), 1)
                            end,
                            
                            
                        },
                    },
                    text {
                        position = dim2(0.5, 0, 0.5, -8),
                        text = "Settings",
                        x_align = ALIGN.CENTER_X,
                        y_align = ALIGN.CENTER_Y,
                    }
                }
            },
            sprite {
                image = assets.sprites.sword_button,
                position = dim2(0.5, 0, 0.8, 0),
                size = dim2(0.5, 0, 0.1, 0),
                anchor = vec2.new(0.5, 0.5),
                scaling = SCALING.CENTER,
            

                children = {
                    button {
                        position = dim2(0.5, 0, 0.5, 0),
                        size = dim2(0.7, 0, 1, 0),
                        anchor = vec2.new(0.5, 0.5),
                        
                        
                        on_click = {
                            -- left button
                            [1] = function()
                                love.event.quit()
                            end,
                            
                            
                        },
                    },
                    text {
                        position = dim2(0.5, 0, 0.5, -8),
                        text = "Quit",
                        x_align = ALIGN.CENTER_X,
                        y_align = ALIGN.CENTER_Y,
                    }  
                }
            },

        }
    }
}    

return startmenu