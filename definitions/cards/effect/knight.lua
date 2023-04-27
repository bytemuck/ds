local c = {
    id = 4,
    name = "Knight",
    description = "Deal 5 damage and\nabsorb 5 damage.",
    rarity = "LEGENDARY",
    image = "effect_3",

    attack = 5,
    defense = 5,
}


c.play = function(self)
    return { self.attack, self.defense }
end

return c