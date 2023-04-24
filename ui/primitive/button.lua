local element = require("element")
local color = require("color")

local mouse = require("mouse")
local clicked = mouse.clicked
local pressed = mouse.pressed

return element.make_new {
    name = "button",

    cctr = function(self)
        self.hold = {}
        self.mouse_button = self.mouse_button or 1

        self.default_color = self.default_color or color.new(0, 0, 0, 0)
        self.hover_color = self.hover_color or color.new(0, 0, 0, 0.25)
        self.click_color = self.click_color or color.new(0.2, 0.2, 0.2, 0.2)

        self.color = self.default_color
    end,
    draw = function(self, go)
        go()

        local pos = self.abs_pos
        local size = self.abs_size
        love.graphics.setColor(self.color)
        love.graphics.rectangle("fill", pos.x, pos.y, size.x, size.y)
    end,
    update = function(self)
        local x, y = love.mouse.getPosition()

        local pos = self.abs_pos
        local size = self.abs_size
        x = x - pos.x
        y = y - pos.y

        local over = (x > 0 and x < size.x) and (y > 0 and y < size.y)
        self.just_entered = (not self.over) and over
        self.just_left = self.over and (not over)
        self.over = over

        for i,v in pairs(self.hold) do
            if not pressed[i] then
                self.hold[i] = nil
                if self.on_release and self.on_release[i] then
                    self.on_release[i](x, y)
                end
            else
                if self.while_hold and self.while_hold[i] then
                    self.while_hold[i](x, y, self)
                end
            end
        end

        if over then
            if self.on_enter then
                if self.just_entered then self.on_enter() end
            end

            for i,v in pairs(clicked) do
                if v then
                    self.hold[i] = true
                    self.color = self.click_color
                    if self.on_click and self.on_click[i] then
                        self.on_click[i](x, y)
                    end
                else
                    self.color = self.hover_color
                end
            end
        else
            if self.on_leave then 
                if self.just_left then self.on_leave() end
            end
            self.color = self.default_color
        end
    end
}
