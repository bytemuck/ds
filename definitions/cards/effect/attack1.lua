local c = {
    id = 1,
    name = "Attack I",
    description = "Deal 3 damage.",
    rarity = "COMMON",
    image = "effect_1",

    attack = 3,
    defense = 0,
}


c.play = function(self)
    return { self.attack, self.defense }
end

return c