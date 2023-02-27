require("registry") -- initialize custom require functionality

local assets = require("assets")
local state = require("state")

local presses = require("mouse")

function love.load()
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
    if state.current then
        state.current.root:update(dt)
    end
end

function love.resize(w, h)
    state.resize(w, h)
end

function love.mousepressed(x, y, button)
    presses[button] = true
end