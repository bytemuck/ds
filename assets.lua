local sprites = {
    load = "load.jpg",
    harry_potter = "hostiles/harry-potter.png",
    monkey = "monkey.jpeg",
    random = "random.jpg",
    squirrel = "squirrel.jpg",
    x_button = "ui/x-button.png",
    sword_button = "ui/sword-button.png",
<<<<<<< Updated upstream
=======
    fond_menu = "background/menu.png",
    game = "background/game.png",
    fond_mauve = "background/fond-mauve.jpg",
    progression = "background/progression.png",
>>>>>>> Stashed changes
    spirit = "spirit.png",
    profile_spirit = "profiles/profile-spirit.png",
    numbers = "numbers.png",
    circle = "circle.png",

    background = {
        game = "game.png",
        menu = "menu.png",
        fond_mauve = "fond-mauve.jpg",
        progression = "progression.png",
    },

    card_background = {
        pivot_1 = "pivot_1.png",
        pivot_2 = "pivot_2.png",

        effect_1 = "effect_1.png",
        effect_2 = "effect_2.png",
        effect_3 = "effect_3.png",
    },
    card_accountrement = {
        common = "none.png",
        rare = "rare.png",
        epic = "epic.png",
        legendary = "legendary.png",
    },

    effects = {
        x2 = "2x.png",
        x3 = "3x.png",
        x4 = "4x.png",
        add = "add.png",
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
    progression_map = {
        filepath = "progression-map.mp3",
        filetype = "stream", -- stream for music, static for sound effects
        looping = true,
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
        for k, v in pairs(sounds) do
            local new = love.audio.newSource("assets/sounds/" .. v.filepath, v.filetype)
            new:setLooping(v.looping)
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

        local card_base = "definitions/cards/"
        self.cards = { effect = {}, pivot = {} }

        for k,v in ipairs(love.filesystem.getDirectoryItems(card_base.."effect/")) do
            local data = love.filesystem.load(card_base.."effect/"..v)()
            self.cards.effect[k] = data
            self.cards.effect[data.id] = data
        end

        for k,v in ipairs(love.filesystem.getDirectoryItems(card_base.."pivot/")) do
            local data = love.filesystem.load(card_base.."pivot/"..v)()
            self.cards.pivot[k] = data
            self.cards.pivot[data.id] = data
        end
    end,
}
