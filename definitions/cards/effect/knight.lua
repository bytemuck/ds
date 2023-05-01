local c = {
    id = 4,
    name = "Chevalier",
    description = "Fait 5 de dégâts et\nprotège 5 de dégâts.",
    rarity = "LEGENDARY",
    image = "effect_3",

    attack = 5,
    defense = 5,
}


c.play = function(self)
    return { self.attack, self.defense }
end

return c