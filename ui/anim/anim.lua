local element = require("element")
local sprite = require("sprite")

return element.make_new {
    cctr = function(self)
        self.animation = self.animation or nil
        self.time = 0
        self.frame = 1
        self.length = self.length or (1 / 24)
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
            self.frame = self.frame + 1
            if self.frame > #self.animation.sprites then
                self.frame = 1
            end
        end

        self.children[1].quad = self.animation.sprites[self.frame]
    end
}
