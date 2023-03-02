local sprites = {
    load = "assets/images/load.jpg",
    monkey = "assets/images/monkey.jpeg",
    random = "assets/images/random.jpg",
    squirrel = "assets/images/squirrel.jpg",
    x_button = "assets/images/ui/x-button.png",
    progression = "assets/images/progression.png"
}

local sounds = {

}

local fonts = {
    roboto = { path = "assets/fonts/Roboto-Regular.ttf", size = 16 }
}

local shaders = {

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
            local new = love.graphics.newFont(v.path, v.size);
            self.fonts[k] = new
        end

        self.shaders = self.shaders or {}
        for k, v in pairs(shaders) do
            local content =  love.filesystem.read(v)
            local new = love.graphics.newShader(content)
            self.shaders[k] = new
        end
    end,
}
