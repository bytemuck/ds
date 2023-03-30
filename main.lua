require("registry") -- initialize custom require functionality

local save = require("save")

local assets = require("assets")
local state = require("state")

local mouse = require("mouse")
local pressed = mouse.pressed
local clicked = mouse.clicked

local flux = require("flux")

function love.load()
    save.load()
    state.resize(love.graphics.getDimensions())
    assets:load()
    state.push(require("states.progression"))
end

function love.draw()
    if state.current then
        state.current.root:draw()
    end
end

function love.update(dt)
    flux.update(dt)

    if state.current then
        state.current.root:update(dt)
    end

    for k,_ in pairs(clicked) do
        clicked[k] = false
    end
end

function love.resize(w, h)
    state.resize(w, h)
end

function love.mousepressed(x, y, button)
    clicked[button] = not pressed[button]
    pressed[button] = true
end

function love.mousereleased(x, y, button)
    clicked[button] = false
    pressed[button] = false
end
