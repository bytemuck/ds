-- create registry
local registry = {}

local function register(t, ...)
    for i=1,select("#", ...) do
        registry[select(i, ...)] = t
    end
end

-- set new require
local old_require = _G.require
_G.require = function(name, ...)
    if not registry[name] then
        local t = { old_require(name) }
        register(t, name, ...)
        return unpack(t)
    end

    if select("#", ...) > 0 then
        register(registry[name], ...)
    end
    return unpack(registry[name])
end

-- REGISTRY --
require("math.random", "random")
require("flux.flux", "flux")

-- ENUMS
require("enum")
require("ui.enum.align", "ui.align")
require("ui.enum.flipmode", "ui.flipmode")
require("ui.enum.scaling", "ui.scaling")
require("definitions.enum.rarity", "rarity")

-- UI
require("ui.struct.color", "color")
require("ui.struct.dim2", "dim2")
require("ui.struct.vec2", "vec2")

require("ui.base.base", "element")
require("ui.base.mouse", "mouse")
require("ui.base.root", "uiroot")

require("ui.primitive.button", "button")
require("ui.primitive.frame", "frame")
require("ui.primitive.group", "group")
require("ui.primitive.line", "line")
require("ui.primitive.sprite", "sprite")
require("ui.primitive.text", "text")

require("ui.anim.anim", "anim")



