local sprites = {
    load = "assets/images/load.jpg",
    monkey = "assets/images/monkey.jpeg",
    random = "assets/images/random.jpg",
    squirrel = "assets/images/squirrel.jpg",
}

local sounds = {

}

local fonts = {

}

return {
    load = function(self)
        self.sprites = self.sprites or {}
        for k, v in pairs(sprites) do
            local new = love.graphics.newImage(v);
            self.sprites[k] = new
        end

        self.audios = self.audios or {}
        for k, v in pairs(sounds) do
            local new = love.audio.newSource(v);
            self.audios[k] = new
        end

        self.fonts = self.fonts or {}
        for k, v in pairs(fonts) do
            -- TODO: Add support for other font types (currently only TrueType)
            local new = love.font.newTrueTypeRasterizer(v);
            self.fonts[k] = new
        end
    end,
}
