local sprites = {
    load = "assets/images/load.jpg",
    monkey = "assets/images/monkey.jpeg",
    random = "assets/images/random.jpg",
    squirrel = "assets/images/squirrel.jpg",
}

local sounds = {

}

return {
    load = function(self)
        for k, v in pairs(sprites) do
            self["sprite/" .. k] = love.graphics.newImage(v)
        end

        for k, v in pairs(sounds) do
            self["sounds/" .. k] = love.audio.newSource(v)
        end
    end,
}
