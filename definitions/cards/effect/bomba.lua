local c = {
    id = 4,
    name = "Bomba",
    description = "Deal 10 damage.",
    rarity = "LEGENDARY",
    image = "effect_3",

    attack = 10,
    defense = 0,
}


c.play = function(self)
    return { self.attack, self.defense }
end

return c