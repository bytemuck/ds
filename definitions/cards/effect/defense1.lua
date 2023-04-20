local c = {
    id = 5,
    name = "Defend I",
    description = "Absorb up to 3 damage.",
    rarity = "COMMON",
    image = "effect_1",

    attack = 0,
    defense = 3,
}

c.play = function(self) 
    return { self.attack, self.defense}
end

return c