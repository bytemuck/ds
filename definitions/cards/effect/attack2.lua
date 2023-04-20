local c = {
    id = 2,
    name = "Attack II",
    description = "Deal 5 damage.",
    rarity = "RARE",
    image = "effect_2",

    attack = 5,
    defense = 0,
}


c.play = function(self)
    return { self.attack, self.defense }
end

return c