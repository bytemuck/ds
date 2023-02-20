local state = require("state")

return function(old_root, new_state, length)
    local pop = not new_state
    if pop then
        new_state = state.stack[#state.stack-1]
    end

    if old_root.transition or new_state.root.transition then return end

    if pop then state.pop() end

    length = length or 1

    local new_root = new_state.root
    local time = 0

    if old_root == new_root then
        error("attempt to transition to self")
    end

    new_root.transition = function(dt)
        print(dt, time, length)
        time = time + dt
        if time >= length then
            new_root.transition = nil
            new_root.after_draw = nil
        end
    end

    new_root.after_draw = function()
        love.graphics.setScissor(0, 0, new_state.root.abs_size.x * (1 - time / length), new_state.root.abs_size.y)
            old_root:draw()
        love.graphics.setScissor()
    end

    state.push(new_state)
end
