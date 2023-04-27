local c = {
    id = 6,
    name = "Defend II",
    description = "Absorb 5 damage.",
    rarity = "RARE",
    image = "effect_2",

    attack = 0,
    defense = 5,
}

c.play = function(self) 
    return { self.attack, self.defense}
end

return c