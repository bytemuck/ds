local element = require("element")
local color = require("color")
local dim2 = require("dim2")
local vec2 = require("vec2")
local assets = require("assets")

local sprite = require("sprite")
local group = require("group")
local button = require("button")

local CARD_WIDTH = 1/7

return element.make_new {
    cctr = function(self)
        self.cards = {} -- cards
        self.cpos = {} -- card positions
        self.cord = {} -- card ordering: k=ord, v=idx
    end,

    on_recalc = function(self)
        self:do_recalc()
    end,

    base = {
        positions = {},

        remove_card = function(self, idx)
            -- TODO
            print(idx)
            self:do_recalc()
        end,

        do_recalc = function(self)
            print("recalc")
            local count = #self.cards
            local width = self.abs_size.x
            local cw = width / math.min(count, 7)
            local hw = cw/2
            local start = width/2 - hw*count

            self.centers = {}
            for ord,idx in pairs(self.cord) do
                local center = start + (ord-1)*cw + hw
                self.children[self.cord[ord]].size = dim2(0, cw, 1, 0)
                self.children[self.cord[ord]].position = dim2(0, center, 1, 0)
                self.centers[ord] = center
            end
        end,

        add_cards = function(self, cards)
            for i,v in ipairs(cards) do
                local ord = #self.cord+1
                v.ord = ord
                self.cord[ord] = #self.cards+1

                self.cards[#self.cards+1] = v

                self:add_child(button {
                    anchor = vec2.new(0.5, 1),

                    children = { v },

                    on_click = {
                        [1] = function(x, y)
                            self.start_x = x
                            self.start_y = y
                            self.start_xs = v.position.xs
                            self.start_ys = v.position.ys
                            self.start_xo = v.position.xo
                        end
                    },
                    while_hold = {
                        [1] = function(x, y)
                            local new_x = self.start_xo + x - self.start_x
                            v.position = dim2(self.start_xs, new_x, self.start_ys, y - self.start_y)

                            print(v.ord, ord)
                            if v.ord > 1 and new_x < self.centers[v.ord-1] then
                                print("swap l")
                                self.cord[v.ord-1], self.cord[v.ord] = self.cord[v.ord], self.cord[v.ord-1]
                                v.ord = v.ord - 1
                            elseif v.ord < #self.cord
                                and new_x > self.centers[v.ord+1] then
                                print("swap r")
                                self.cord[v.ord+1], self.cord[v.ord] = self.cord[v.ord], self.cord[v.ord+1]
                                v.ord = v.ord + 1
                            end
                        end
                    },
                    on_release = {
                        [1] = function()
                            v.position = dim2(0, 0, 0, 0)
                            self:recalc()
                        end
                    }
                })
            end

            self:do_recalc()
        end
    }
}