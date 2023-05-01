local c = {
    id = 2,
    name = "Attaque II",
    description = "Fait 5 de dégâts.",
    rarity = "RARE",
    image = "effect_2",

    attack = 5,
    defense = 0,
}


c.play = function(self)
    return { self.attack, self.defense }
end

return c