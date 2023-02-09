local uiroot = require("ui.root")
local dim2 = require("ui.dim2")

local state = {}

local width, height

function state.resize(w, h)
    width = w
    height = h
    if state.current then
        state.current.resize(w, h)
    end
end

function state.new()
    local root = uiroot()
    root.size = dim2(0, width, 0, height)
    return {
        root = root,
        resize = function(w, h)
            root.size = dim2(0, w, 0, h)
            print("set size")
        end
    }
end

function state.set(new_state)
    state.current = new_state
    if new_state.start then
        new_state.start()
    end
    new_state.resize(width, height)
end

return state
