local element = require("element")
local card = require("ui.card.card")

return element.make_new {
    cctr = function(self)
        assert(self.id)
        self.id = self.id
        self.is_pivot_side = not not self.is_pivot_side
    end,

    postcctr = function(self)
        self:add_child(card {
            id = self.id,
            is_pivot_side = self.is_pivot_side
        })
    end,
}
