local c = {
    id = 1,
    name = "Attaque I",
    description = "Fait 3 de dégâts.",
    rarity = "COMMON",
    image = "effect_1",

    attack = 3,
    defense = 0,
}


c.play = function(self)
    return { self.attack, self.defense }
end

return c