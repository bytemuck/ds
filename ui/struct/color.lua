-- Auteurs : Jonas Lépine

--[[
    Color: Color. Immutable.
]]

local color = {}

local keys = { r = 1, g = 2, b = 3, a = 4 }

function color.scl(a, k)
    return color.new(k*a.r, k*a.g, k*a.b, k*a.a)
end

-- Constructor
function color.new(r, g, b, a)
    return setmetatable({ r, g, b, a }, {
        __index = function(self, k)
            return self[keys[k]] or color[k]
        end,
        __newindex = function(self, key, value)
            error("attempt to assign to an immmutable object (color)")
        end,

        __tostring = function(self)
            return string.format("rgba(%.2f, %.2f, %.2f, %.2f)", unpack(self))
        end,

        __mul = color.scl,
    })
end

return color
