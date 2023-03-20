local state = require("state")
local cardchoice = state.new("cardchoice")
local root = cardchoice.root

local transition = require("transition")
local SCALING = require("ui.scaling")
local FLIPMODE = require("ui.flipmode")
local ALIGN = require("ui.align")

local assets = require("assets")

local frame = require("frame")
local button = require("button")
local color = require("color")
local dim2 = require("dim2")
local vec2 = require("vec2")
local text = require("text")
local sprite = require("sprite")

root:add_children{
    sprite {
        image = assets.sprites.fond_mauve,
        position = dim2(0, 0, 0, 0),
        size = dim2(1, 0, 1, 0),
        scaling = SCALING.STRETCH,

        children = {
            button {
                position = dim2(0.2, 0, 0.5, 0),
                size = dim2(0.25, 0, 0.3, 0),
                anchor = vec2.new(0.5, 0.5),

                on_click = {
                    -- left button
                    [1] = function()
                        -- transition(root, require("states.progression"), 1)
                    end,
                    -- right button
                    [2] = function()
                        -- do nothing
                    end
                },

                children = {
                    frame {
                        color = color.new(1, 0, 0, 1),
                    },
                    text {
                            position = dim2(0.5, 0, 0.5, 0),
                            text = "Ta",
                            font = assets.fonts.roboto[42],
                            x_align = ALIGN.CENTER_X,
                            y_align = ALIGN.CENTER_Y,
                            color = color.new(0, 0, 0, 1),
                        }  
                }
            },
            button {
                position = dim2(0.5, 0, 0.5, 0),
                size = dim2(0.25, 0, 0.3, 0),
                anchor = vec2.new(0.5, 0.5),

                on_click = {
                    -- left button
                    [1] = function()
                        -- transition(root, require("states.progression"), 1)
                    end,
                    -- right button
                    [2] = function()
                        -- do nothing
                    end
                },

                children = {
                    frame {
                        color = color.new(1, 0, 0, 1),
                    },
                    text {
                        position = dim2(0.5, 0, 0.5, 0),
                        text = "mère",
                        font = assets.fonts.roboto[42],
                        x_align = ALIGN.CENTER_X,
                        y_align = ALIGN.CENTER_Y,
                       color = color.new(0, 0, 0, 1),
                    } 
                }
            },
            button {
                position = dim2(0.8, 0, 0.5, 0),
                size = dim2(0.25, 0, 0.3, 0),
                anchor = vec2.new(0.5, 0.5),

                on_click = {
                    -- left button
                    [1] = function()
                        -- transition(root, require("states.progression"), 1)
                    end,
                    -- right button
                    [2] = function()
                        -- do nothing
                    end
                },

                children = {
                    frame {
                        color = color.new(1, 0, 0, 1),
                    },
                    text {
                        position = dim2(0.5, 0, 0.5, 0),
                        text = "la ...",
                        font = assets.fonts.roboto[42],
                        x_align = ALIGN.CENTER_X,
                        y_align = ALIGN.CENTER_Y,
                        color = color.new(0, 0, 0, 1),
                    }  
                }
            },
            button {
                position = dim2(0.9, 0, 0.9, 0),
                size = dim2(0.1, 0, 0.1, 0),
                anchor = vec2.new(0.5, 0.5),

                on_click = {
                    -- left button
                    [1] = function()
                       -- transition(root, require("states.progression"), 1)
                    end,
                    -- right button
                    [2] = function()
                        -- do nothing
                    end
                },
                children = {
                    frame {
                        color = color.new(1, 0, 0, 1),
                    },
                    text {
                        position = dim2(0.5, 0, 0.5, 0),
                        text = "Skip",
                        font = assets.fonts.roboto[42],
                        x_align = ALIGN.CENTER_X,
                        y_align = ALIGN.CENTER_Y,
                        color = color.new(0, 0, 0, 1),
                    }  
                }
            },
        }
    }
    
 }



return cardchoice