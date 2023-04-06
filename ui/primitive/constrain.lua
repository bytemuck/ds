local vec2 = require("vec2")
local element = require("element")
local SCALING = require("ui.scaling")

return element.make_new {
    cctr = function(self)
        self.ratio = self.ratio or 1 -- only required for some scaling mechanisms
    end,

    on_recalc = function(self)
        self.__abs_size = self.abs_size
        self.__abs_pos = self.abs_pos
        self:constrain()
    end,

    base = {
        __abs_size = vec2.new(0, 0),
        __abs_pos = vec2.new(0, 0),

        constrain = function(self, no_child_recalc)
            local child = self.children[1]
            if self.scaling == SCALING.STRETCH then
                -- nothing to do
            elseif self.scaling == SCALING.CENTER then
                local ew, eh = self.__abs_size.x, self.__abs_size.y

                if not no_child_recalc then
                    child:recalc()
                end
                local cs = child.abs_size
                local cw, ch = cs.x, cs.y

                if cw/ch > ew/eh then
                    self.abs_pos.y =  self.__abs_pos.y + (eh - ch * (ew/cw)) / 2
                else
                    local padding = ew - cw * (eh/ch)
                    self.abs_pos.x = self.__abs_pos.x + padding / 2
                    self.abs_size.x = self.__abs_size.x - padding
                end
            elseif self.scaling == SCALING.OVERFLOW_RIGHT then
                self.abs_size.x = self.abs_size.y * self.ratio
            else
                error("nyi")
            end
        end
    }
}
