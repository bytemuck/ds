local uiroot = require("uiroot")
local dim2 = require("dim2")

local stack = {}
local state = { stack = stack }

local width, height

function state.resize(w, h)
    width = w
    height = h
    if state.current then
        state.current.resize(w, h)
    end
end

function state.new(name)
    local root = uiroot { name = name }
    root.size = dim2(0, width, 0, height)
    return {
        root = root,
        resize = function(w, h)
            root.size = dim2(0, w, 0, h)
        end
    }
end

function state._set(new_state)
    state.current = new_state
    if new_state.start then
        new_state.start()
    end
    new_state.resize(width, height)
end

function state.pop()
    stack[#stack] = nil
    local top = stack[#stack]
    state._set(top)
    return top
end

function state.push(new_state)
    if new_state ~= stack[#stack] then
        stack[#stack+1] = new_state
    end
    state._set(new_state)
end

return state
