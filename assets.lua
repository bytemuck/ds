local sprites = {
    load = "assets/images/load.jpg",
    monkey = "assets/images/monkey.jpeg",
    random = "assets/images/random.jpg",
    squirrel = "assets/images/squirrel.jpg",
    x_button = "assets/images/ui/x-button.png",
    sword_button = "assets/images/ui/sword-button.png",
    fond_menu = "assets/images/fond-menu.png",
    progression = "assets/images/progression.png",
    spirit = "assets/images/spirit.png"
}

local animations = {
    monkey_idle = {
        path = sprites.monkey,
        width = 128,
        height = 128,
    }
}

local sounds = {

}

local fonts = {
    roboto = "assets/fonts/Roboto-Regular.ttf"
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
            self.fonts[k] = setmetatable({}, {
                __index = function(t, key)
                    local value = rawget(t, key)
                    if value then
                        return value
                    else
                        t[key] = love.graphics.newFont(v, key)
                        return rawget(t, key)
                    end
                end
            })
        end

        self.animations = self.animations or {}
        for k, v in pairs(animations) do
            local animation = {
                spriteSheet = love.graphics.newImage(v.path),
                sprites = {}
            }

            for y = 0, animation.spriteSheet:getHeight() - v.height, v.height do
                for x = 0, animation.spriteSheet:getWidth() - v.width, v.width do
                    table.insert(animation.sprites, love.graphics.newQuad(x, y, v.width, v.height, animation.spriteSheet))
                end
            end

            self.animations[k] = animation
        end

        self.shaders = self.shaders or {}
        for k, v in pairs(shaders) do
            local content =  love.filesystem.read(v)
            local new = love.graphics.newShader(content)
            self.shaders[k] = new
        end
    end,
}
