-- Auteurs : Jonas Lépine, Nathan Pinard

local element = require("element")
local color = require("color")
local dim2 = require("dim2")
local vec2 = require("vec2")
local assets = require("assets")

local sprite = require("sprite")
local group = require("group")
local button = require("button")
local text = require("text")
local ALIGN = require("ui.align")

local card_expanded = require("ui.card.card_expanded")
local isTrue = false

local CARD_COUNT = 6
local CARD_ASPECT_RATIO = 1.4

local HAND_MOVE_TIME = 0.25
local HAND_EASING = "circout"

local flux = require("flux")

local save = require("save")

return element.make_new {
    name = "hand",

    cctr = function(self)
        self.cards = {}
        self.cord = {}
    end,

    postcctr = function(self) end,

    on_recalc = function(self)
        self:do_recalc()
    end,

    base = {
        reset = function(self)
            self.slots = {}
            self.cards = {}
            self.cord = {}
            self:recalc()
        end,

        do_recalc = function(self)
            local count = #self.cards
            if count == 0 then
                if not self.children or #self.children ~= 0 then
                    self.children = {}
                end
                return
            end
            local width = self.abs_size.x
            local cw = width / math.max(count, CARD_COUNT)
            local hw = cw / 2
            local start = width / 2 - hw * count

            self.centers = {}
            for ord, idx in pairs(self.cord) do
                local center = start + (ord - 1) * cw + hw
                self.children[idx].size = dim2(0, cw, 0, cw * CARD_ASPECT_RATIO)
                self.children[idx].position = dim2(0, center, 1, 0)
                self.centers[ord] = center
            end
        end,

        add_cards = function(self, cards)
            for _, v in ipairs(cards) do
                local ord = #self.cord + 1
                v.ord = ord
                self.cord[ord] = #self.cards + 1

                self.cards[#self.cards + 1] = v

                self:add_child(button {
                    anchor = vec2.new(0.5, 1),

                    children = { v },

                    on_enter = function()
                        local what = v.is_pivot_side and "pivot" or "effect"

                        local ce = card_expanded {
                            position = dim2(0.5, 0, 0, 0),
                            size = dim2(0, 512, 0, 512),
                            anchor = vec2.new(0.5, 0.75),

                            id = v.id,
                            is_pivot_side = v.is_pivot_side,

                            title = v[what].name,
                            description = v[what].description,

                            isTrue = true
                        }

                        ce:fuck_text(not v.is_pivot_side)

                        v.on_flip = function()
                            local what = v.is_pivot_side and "pivot" or "effect"
                            ce.title_obj.text_objs = ce.title_obj.update_text(v[what].name or "Untitled")
                            ce.description_obj.text_objs = ce.description_obj.update_text(v[what].description or "No description")
                            ce:fuck_text(not v.is_pivot_side)
                        end

                        v.children[#v.children + 1] = ce
                        ce.parent = v
                        ce:recalc()
                    end,

                    on_leave = function()
                        v.children[#v.children] = nil
                    end,

                    on_click = {
                        [1] = function(x, y)
                            self.start_ord = v.ord
                            self.start_x = x
                            self.start_y = y
                            self.start_xs = v.position.xs
                            self.start_ys = v.position.ys

                            -- remove expanded card
                            if v.children[#v.children].is_pivot_side then
                                v.children[#v.children] = nil
                            end
                            v.can_turn = false
                        end,

                        [2] = function(x, y) end -- do not remove?
                    },

                    while_hold = {
                        [1] = function(x, y, buttonself)
                            v.position = dim2(self.start_xs, x - self.start_x, self.start_ys, y - self.start_y)

                            x = x + v.parent.position.xo
                            if v.ord > 1 and x < self.centers[v.ord - 1] + (buttonself.abs_size.x/2) then
                                local other = self.cards[self.cord[v.ord - 1]]
                                self.cord[v.ord - 1], self.cord[v.ord] = self.cord[v.ord], self.cord[v.ord - 1]
                                v.ord = v.ord - 1
                                other.ord = other.ord + 1

                                flux.to(other.parent.position, 0.25, dim2(0, self.centers[v.ord + 1], 1, 0).vals):ease(
                                HAND_EASING)
                            elseif v.ord < #self.cord and x > self.centers[v.ord + 1] + (buttonself.abs_size.x/2) then
                                local other = self.cards[self.cord[v.ord + 1]]
                                self.cord[v.ord + 1], self.cord[v.ord] = self.cord[v.ord], self.cord[v.ord + 1]
                                v.ord = v.ord + 1
                                other.ord = other.ord - 1

                                flux.to(other.parent.position, 0.25, dim2(0, self.centers[v.ord - 1], 1, 0).vals):ease(
                                HAND_EASING)
                            end
                        end
                    },

                    on_release = {
                        [1] = function()
                            v.can_turn = true

                            local m = vec2.new(love.mouse.getPosition())
                            for _,slot in pairs(self.slots) do
                                local p = m - slot.abs_pos
                                if p.x > 0 and p.y > 0 and p.x < slot.abs_size.x and p.y < slot.abs_size.y then
                                    if v.children[#v.children].is_pivot_side ~= nil then
                                        v.children[#v.children] = nil
                                    end

                                    local new = self.create_card(save.draw_deck())
                                    local idx = self.cord[v.ord]
                                    new.ord = v.ord
                                    self.cards[idx] = new
                                    new.parent = v.parent
                                    v.parent.children = { new }

                                    v.position = dim2(0, 0, 0, 0)
                                    v.parent = slot.parent
                                    slot.parent:fill_slot(slot.idx, v)

                                    v = new

                                    slot.parent:recalc()
                                    self:recalc()

                                    v.position = dim2(0, 0, 1.1, 0)
                                    flux.to(v.position, 0.5, dim2(0, 0, 0, 0).vals):ease(HAND_EASING)

                                    self.reset_slots()
                                    return
                                end
                            end

                            -- if no slots are being filled, bring back the card to the hand
                            local old_abs_pos = v.parent.abs_pos
                            self:recalc()
                            v.position.xo = v.position.xo + (old_abs_pos.x - v.parent.abs_pos.x)
                            flux.to(v.position, 0.5, dim2(0, 0, 0, 0).vals):ease(HAND_EASING)
                        end
                    }
                })
            end

            self:do_recalc()
        end
    }
}
