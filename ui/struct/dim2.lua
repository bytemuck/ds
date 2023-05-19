-- Auteurs : Jonas Lépine

--[[
    Dim2: 2D "Dimension". The Position and Size of UI elements.

    Comprised of a "Scale" and an "Offset", both of X and Y. Scale is a
    multiplier of the parent's dimensions, while offset is an absolute
    difference in pixels. The X Scale, X Offset, Y Scale and Y Offset are
    respectively acronymed to xs, xo, ys, and yo.

    Also contains an array of functions, added by UI elements, so that they are
    recalculated upon the modification of the Dim2.

    With an Dim2 object `u`, you can:
        Access the 4 properties:
            u.xs
            u.xo
            u.ys
            u.yo
        Modify the 4 properties individually:
            u.xs = 0.5
            u.xo = 2
            u.ys = 0.5
            u.yo = 2
        Do multiple assignment of many properties at once:
            u { xo = 4, yo = 4 }
]]

local keys = { xs = 1, xo = 2, ys = 3, yo = 4 }

-- Update function, calls all recalculation functions.
-- Called whenever one of the 4 properties of the Dim2 changes. 
local function update(self)
    for _,f in pairs(self[0]) do
        f()
    end
end

-- Constructor
local new = function(xs, xo, ys, yo, e)
    return setmetatable({ [0] = { e }, xs, xo, ys, yo }, {
        -- Assignment
        __newindex = function(self, key, value)
            if not keys[key] then error("key") end
            self[keys[key]] = value
            update(self)
        end,
        -- Property Access
        __index = function(self, k)
            if k == "vals" then
                return { xs = self[1], xo = self[2], ys = self[3], yo = self[4] }
            end
            if not keys[k] then error("key") end
            return self[keys[k]]
        end,
        -- Call for easy multiple assignment
        __call = function(self, t, ...)
            if select("#", ...) ~= 0 then error("args") end
            if type(t) ~= "table" then return end

            for k,v in pairs(t) do
                if not keys[k] then error("key") end
                self[keys[k]] = v
            end
            update(self)
        end,

        __tostring = function(self)
            return "dim2(" .. table.concat(self, ", ") .. ")"
        end
    })
end

return new
