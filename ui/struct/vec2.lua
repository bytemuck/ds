-- Auteurs : Jonas Lépine

--[[
    Vec2: 2D Vector. Immutable.

    All functions operating on vectors are defined directly in this module,
    and as methods on the vec2 objects. That is, all of the following code is
    valid:
        a, b = vec2.new(2, 0), vec2.new(0, 2)
        print(vec2.dot(a, b)) --> 0
        print(a:dot(b))       --> 0
        print(a:dot(a + b))       --> 0

]]

local vec2 = {}

-- Base operations
function vec2.add(a, b)
    return vec2.new(a.x + b.x, a.y + b.y)
end

function vec2.sub(a, b)
    return vec2.new(a.x - b.x, a.y - b.y)
end

function vec2.neg(a)
    return vec2.new(-a.x, -a.y)
end

function vec2.eq(a, b)
    return a.x == b.x and a.y == b.y
end

function vec2.scl(a, k)
    return vec2.new(k*a.x, k*a.y)
end

function vec2.dot(a, b)
    return a.x*b.x + a.y*b.y
end

-- Constructor
function vec2.new(x, y)
    return setmetatable({ x = x, y = y }, {
        __index = vec2,
        __newindex = function(self, key, value)
            error("attempt to assign to an immmutable object (vec2)")
        end,

        __add = vec2.add,
        __sub = vec2.sub,
        __mul = function(a, b)
            if type(a) == "number" then
                return b:scl(a)
            elseif type(b) == "number" then
                return a:scl(b)
            else
                return a:dot(b)
            end
        end,
        __unm = vec2.neg,
        __eq = vec2.eq,

        __tostring = function(self)
            return "vec2(" .. self.x .. ", " .. self.y .. ")"
        end
    })
end


return vec2
