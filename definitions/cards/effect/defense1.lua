local c = {
    id = 5,
    name = "Défense I",
    description = "Protège 3 de dégâts.",
    rarity = "COMMON",
    image = "effect_1",

    attack = 0,
    defense = 3,
}

c.play = function(self) 
    return { self.attack, self.defense}
end

return c