local RARITY = require("rarity")
local random = require("random").new()

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
    local rarity = random:nextRangeInt(RARITY.COMMON, RARITY.LEGENDARY + 1, 0.2)
    local id = random:nextRangeInt(1, #cards[rarity] + 1)

    return id
end

return cards
