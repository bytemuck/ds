-- Auteurs : Benjamin Breboin

local c = {
    id = 6,
    name = "Défense II",
    description = "¨Protège 5 de dégâts.",
    rarity = "RARE",
    image = "effect_2",

    attack = 0,
    defense = 5,
}

c.play = function(self) 
    return { self.attack, self.defense}
end

return c