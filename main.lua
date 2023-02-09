local asset_loader = require("asset_loader")
local state = require("state")

local width, height = 1024, 768
state.resize(w, h)

function love.load()
    state.resize(love.graphics.getDimensions())
    asset_loader.load()
    state.set(require("states.debug"))
end

function love.draw()
    if state.current then
        state.current.root:draw()
    end
end

function love.update()
    if state.current then
        state.current.root:update()
    end
end

function love.resize(w, h)
    state.resize(w, h)
end
