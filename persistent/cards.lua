local RARITY = require("rarity")
local random = require("random").new(69)

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
    local rarity = random.nextRangeInt(RARITY.COMMON, RARITY.LEGENDARY, 0.1)
    local id = random.nextRangeInt(1, #cards[rarity], 0.5)

    return id
end

return cards
