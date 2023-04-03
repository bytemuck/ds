local element = require("element")
local SCALING = require("ui.scaling")

return element.make_new {
    cctr = function(self)
        self.ratio = self.ratio or 1 -- only required for some scaling mechanisms
    end,

    on_recalc = function(self)
        local child = self.children[1]
        if self.scaling == SCALING.STRETCH then
            -- nothing to do
        elseif self.scaling == SCALING.CENTER then
            local ew, eh = self.abs_size.x, self.abs_size.y

            child:recalc()
            local cs = child.abs_size
            local cw, ch = cs.x, cs.y

            if cw/ch > ew/eh then
                self.abs_pos.y = self.abs_pos.y + (eh - ch * (ew/cw)) / 2
            else
                self.abs_pos.x = self.abs_pos.x + (ew - cw * (eh/ch)) / 2
            end
        elseif self.scaling == SCALING.OVERFLOW_RIGHT then
            self.abs_size.x = self.abs_size.y * self.ratio
        else
            error("nyi")
        end
    end
}
