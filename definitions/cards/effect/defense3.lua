local c = {
    id = 7,
    name = "Defend III",
    description = "Absorb up to 7 damage.",
    rarity = "EPIC",
    image = "effect_3",

    attack = 0,
    defense = 7,
}

c.play = function(self) 
    return { self.attack, self.defense}
end

return c