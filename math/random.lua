local bit = require("bit")

local random = {}

-- note: do not edit modulus, bit mask only works if it is a power of 2
local modulus = 2 ^ 31
local mask = modulus - 1

local mult = 1103515245
local incr = 12345

random.halfskew = 0.7864397013 -- skew for (0.5, 0.5)

function random.new(seed, skew, invert)
    return setmetatable({
        state = seed,
        modulus = modulus,
        min = 0,
        skew = skew,
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

-- if skewed: use inverse transform sampling to get value in a sampling distribution
function random:next()
    local value = self:nextUniform()

    if self.skew then
        value = 4 / math.pi * math.atan(value ^ self.skew)
    end

    if self.invert then
        value = 1 - value
    end

    return value
end

-- generate a double value in an arbitrary range
function random:nextRange(min, max)
    return min + (max - min) * self:nextUniform()
end

-- generate an integer value in an arbitrary range
function random:nextRangeInt(min, max)
    return math.floor(self:nextRange(min, max))
end

return random
