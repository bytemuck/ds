local element = require("element")
local assets = require("assets")
local sprite = require("sprite")

return element.make_new {
    cctr = function(self)
        self.animation = self.animation or nil
        self.time = 0
        self.length = self.length or 1
    end,

    postcctr = function(self)
        self:add_child(sprite {
            image = self.animation.spriteSheet,
            quad = self.animation.sprites[1]
        })
    end,

    update = function(self, dt)
        self.time = self.time + dt
        if self.time >= self.length then
            self.time = self.time - self.length
        end

        local n = #self.animation.sprites
        local i = math.floor(self.time / self.length * n) + 1
        self.children[1].quad = self.animation.sprites[n]
    end
}
