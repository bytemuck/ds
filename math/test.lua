-- Auteurs : Jonas Lépine

local r = require("random")
local inst = r.new()

local n = 1000
for a=0.05,2,0.05 do
    local sum = 0
    for i=1,n do
        sum = sum + inst:next(a)
    end
    print(a, sum/n)
end
