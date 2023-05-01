local c = {
    id = 7,
    name = "Défense III",
    description = "Protège 7 de dégâts.",
    rarity = "EPIC",
    image = "effect_3",

    attack = 0,
    defense = 7,
}

c.play = function(self) 
    return { self.attack, self.defense}
end

return c