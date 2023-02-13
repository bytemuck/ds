local state = require("state")

return function(old_root, new_state, length)
    local new_root = new_state.root
    local time = 0

    state.push(new_state)

    new_root.transition = function(dt)
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
end
