local sprites = {
    load = "load.jpg",
    harry_potter = "hostiles/harry-potter.png",
    monkey = "monkey.jpeg",
    random = "random.jpg",
    squirrel = "squirrel.jpg",
    x_button = "ui/x-button.png",
    sword_button = "ui/sword-button.png",
    fond_menu = "fond-menu.png",
    fond_mauve = "fond-mauve.jpg",
    progression = "progression.png",
    spirit = "spirit.png",
    profile_spirit = "profiles/profile-spirit.png",
    numbers = "numbers.png",

    card_background = {
        common_effect = "common_effect.png",
        common_pivot = "common_pivot.png",
    },
    card_accountrement = {
        common = "none.png",
        rare = "rare.png",
        epic = "epic.png",
        legendary = "legendary.png",
    }
}

local animations = {
    monkey_idle = {
        name = "monkey",
        width = 128,
        height = 128,
    },
    numbers_idle = {
        name = "numbers",
        width = 24,
        height = 24,
    }
}

local sounds = {
    mymusic = {
        path = "assets/audios/mymusic.mp3",
        filetype = "stream" -- stream for music, static for sound effects
    }
}

local fonts = {
    roboto = "assets/fonts/Roboto-Regular.ttf"
}

local shaders = {

}

local function load_sprites(folder, src, tgt)
    for k, v in pairs(src) do
        if type(v) == "table" then
            local new = {}
            tgt[k] = new
            load_sprites(folder .. k .. "/", v, new)
        else
            tgt[k] = love.graphics.newImage(folder..v)
        end
    end
end

return {
    load = function(self)
        self.sprites = self.sprites or {}
        load_sprites("assets/images/", sprites, self.sprites)

        self.audios = self.audios or {}
        for k, v in pairs(shaders) do
            local new = love.audio.newSource(v.filepath, v.filetype)
            self.audois[k] = new
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
                spriteSheet = self.sprites[v.name],
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
