local c = {
    id = 3,
    name = "Attack III",
    description = "Deal 7 damage.",
    rarity = "EPIC",
    image = "effect_2",

    attack = 7,
    defense = 0,
}


c.play = function(self)
    return { self.attack, self.defense }
end

return c