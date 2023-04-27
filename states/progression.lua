local state = require("state")
local progression = state.new("debug")
local root = progression.root

local dim2 = require("dim2")
local vec2 = require("vec2")

local SCALING = require("ui.scaling")
local ALIGN = require("ui.align")

local transition = require("transition")
local group = require("group")
local button = require("button")
local frame = require("frame")
local color = require("color")
local line = require("line")
local sprite = require("sprite")
local text = require("text")

local persistent = require("persistent")

local assets = require("assets")
local random = require("random").new(69)

local flux = require("flux")

local target_point

assets.audios.progression_map:play()

local function advance()
    flux.to(root.children[5].position, 1, target_point.position.vals):oncomplete(function()
        assets.audios.progression_map:stop()
        state.push(require("states.game"))
    end)
end

local function back()
    assets.audios.progression_map:stop()
    transition(root, state.pop(), 1)
end


local function generate_tree(from)
    local LEVEL_COUNT = 5

    local last
    for i = 1, from or 0 do
        last = random:nextRange(0.6, 0.9)
    end

    local back = frame {
        position = dim2(0, 32, 1, -32),
        size = dim2(0, 256, 0, 96),
        anchor = vec2.new(0, 1),
        children = {
            button {
                on_click = {
                    [1] = function()
                        -- BAAAAAAACCCKKKKKKKKKKK!!!!!
                        back()
                    end
                }
            },
            text {
                position = dim2(0.5, 0, 0.5, 0),
                text = "RETOUR",
                font = assets.fonts.roboto[42],
                x_align = ALIGN.CENTER_X,
                y_align = ALIGN.CENTER_Y,
                color = color.new(0, 0, 0, 1),
            }
        }
    }

    local battle = frame {
        position = dim2(1, -32, 1, -32),
        size = dim2(0, 256, 0, 96),
        anchor = vec2.new(1, 1),
        children = {
            button {
                on_click = {
                    [1] = function()
                        -- ATTTAAACCCKKKK!!!!!
                        advance()
                    end
                }
            },
            text {
                position = dim2(0.5, 0, 0.5, 0),
                text = "COMBATTRE",
                font = assets.fonts.roboto[42],
                x_align = ALIGN.CENTER_X,
                y_align = ALIGN.CENTER_Y,
                color = color.new(0, 0, 0, 1),
            }
        }
    }
    local points = group {}
    local lines = group {}

    for i = last and 0 or 1, LEVEL_COUNT do
        local y = i == 0 and last or random:nextRange(0.6, 0.9)
        local x = (i / LEVEL_COUNT)

        local point = frame {
            position = dim2(x, 0, y, 0),
            size = dim2(0.0, 32, 0.0, 32),
            anchor = vec2.new(0.5, 0.5),
            color = (not last and i == 1) and color.new(0, 1, 0, 1) or color.new(1, 0, 0, 1)
        }

        points:add_child(point)

        if i == 2 then
            target_point = point
        end
    end

    for i = 1, #points.children - 1 do
        local a = points.children[i].position
        local b = points.children[i + 1].position

        if b then
            points:add_children {
                line {
                    position = dim2(a.xs, a.xo, a.ys, b.yo),
                    size = dim2(b.xs, b.xo, b.ys, b.yo),
                    color = color.new(1, 1, 1, 1)
                }
            }
        end
    end

    local spirit = sprite {
        image = assets.sprites.spirit,
        position = dim2(points.children[last and 2 or 1].position.xs, 0, points.children[last and 2 or 1].position.ys, 0),
        size = dim2(0, 100, 0, 100),
        anchor = vec2.new(0.5, 0.5),
        scaling = SCALING.CENTER_OVERFLOW,
    }

    root:add_children {
        sprite {
            image = assets.sprites.background.progression,
            position = dim2(0, 0, 0, 0),
            size = dim2(1, 0, 1, 0),
            scaling = SCALING.CENTER_OVERFLOW,
        },
        lines,
        points,
        battle,
        spirit,
        back,
    }
end

generate_tree(persistent.level)
return progression
