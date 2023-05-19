-- Auteurs : Jonas Lépine

local bit = require("bit")

local random = {}

-- note: do not edit modulus, bit mask only works if it is a power of 2
local modulus = 2 ^ 31
local mask = modulus - 1

local mult = 1103515245
local incr = 12345

function random.new(seed, a, invert)
    return setmetatable({
        state = seed or os.time(),
        modulus = modulus,
        a = a,
        invert = not not invert,
    }, { __index = random })
end

-- generate a new integer value
function random:nextRaw()
    self.state = bit.band(mask, mult * self.state + incr) -- x = (a*x + c) mod m
    return self.state
end

-- generate a double value in the [0, 1] range
function random:nextUniform()
    return self:nextRaw() / mask
end

-- use inverse transform sampling to get skewed value (non-uniform); still in [0, 1]
function random:next(a)
    local value = self:nextUniform()

    if not a then
        a = self.a
    end

    if a then
        value = value ^ a
    end

    if self.invert then
        value = 1 - value
    end

    return value
end

-- generate a double value in an arbitrary range
function random:nextRange(min, max, a)
    return min + (max - min) * self:next(a)
end

-- generate an integer value in an arbitrary range
function random:nextRangeInt(min, max, a)
    return math.floor(self:nextRange(min, max, a))
end

return random
