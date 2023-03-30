local element = require("element")
local SCALING = require("ui.scaling")

return element.make_new {
    cctr = function(self)
        self.ratio = self.ratio or 1 -- x/y
    end,

    on_recalc = function(self)
        if self.scaling == SCALING.OVERFLOW_RIGHT then
            self.abs_size.x = self.abs_size.y * self.ratio
        else
            error("nyi")
        end
    end
}
