local element = require("element")
local dim2 = require("dim2")

local presses = require("mouse")

return element.make_new {
    cctr = function(self)
        self.old_state = nil
        self.size = dim2(0, 1024, 0, 768)
    end,

    draw = function(self, go)
        if self.before_draw then self.before_draw() end
        go()
        if self.after_draw then self.after_draw() end
    end,

    update = function(self, dt)
        if self.transition then
            self.transition(dt)
        end

        presses = {}
    end
}
