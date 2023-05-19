-- Auteurs : Jonas Lépine

local vec2 = require("vec2")
local element = require("element")
local SCALING = require("ui.scaling")

return element.make_new {
    name = "constrain",

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

                local cm = child.constrain_mult or vec2.new(1, 1)
                local cs = child.abs_size
                local cw, ch = cs.x * cm.x, cs.y * cm.y

                if cw/ch > ew/eh then
                    local padding = eh - ch * (ew/cw)
                    self.abs_pos = vec2.new(self.__abs_pos.x, self.__abs_pos.y + padding / 2)
                    self.abs_size = vec2.new(self.abs_size.x, self.__abs_size.y - padding)
                    self.abs_size.x = self.abs_size.x * (self.abs_size.y/self.__abs_size.y)
                else
                    local padding = ew - cw * (eh/ch)
                    self.abs_pos = vec2.new(self.__abs_pos.x + padding / 2, self.__abs_pos.y)
                    self.abs_size = vec2.new(self.__abs_size.x - padding, self.abs_size.y)
                    self.abs_size.y = self.abs_size.y * (self.abs_size.x/self.__abs_size.x)
                end
            elseif self.scaling == SCALING.OVERFLOW_RIGHT then
                self.abs_size.x = self.abs_size.y * self.ratio
            else
                error("nyi")
            end
        end
    }
}
