local RARITY = require("rarity")
local random = require("random").new()
local persistent = require("persistent")

local cards = {
    [RARITY.COMMON] = {
        0, 1, 5
    },
    [RARITY.RARE] = {
        2, 6
    },
    [RARITY.EPIC] = {
        3, 1, 7
    },
    [RARITY.LEGENDARY] = {
        4
    },
}

cards.next = function()
    local rarity = random:nextRangeInt(RARITY.COMMON, RARITY.LEGENDARY + 1, 1/(1+persistent.level))
    local id = random:nextRangeInt(1, #cards[rarity] + 1)

    return id
end

return cards
