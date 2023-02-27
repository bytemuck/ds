return function(min, max) -- random, but with floating numbers
    local range = math.abs(max - min)
    return min + (love.math.random() * range)
end