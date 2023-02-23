local element = require("element")
local sprite = require("sprite")
local SCALING = require("ui.scaling")

return element.make_new {
    cctr = function(self)
        self:add_children {
            -- sprite
        }
    end
}
