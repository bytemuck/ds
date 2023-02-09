local ui = require("ui.base")
local dim2 = require("ui.dim2")

return ui.make_new {
    cctr = function(self)
        self.size = dim2(0, 1024, 0, 768)
    end
}
