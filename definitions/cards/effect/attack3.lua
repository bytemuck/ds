local c = {
    id = 3,
    name = "Attaque III",
    description = "Fait 7 de dégâts.",
    rarity = "EPIC",
    image = "effect_2",

    attack = 7,
    defense = 0,
}


c.play = function(self)
    return { self.attack, self.defense }
end

return c