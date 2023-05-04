local element = require("element")
local color = require("color")
local dim2 = require("dim2")
local vec2 = require("vec2")
local assets = require("assets")

local sprite = require("sprite")
local group = require("group")
local button = require("button")
local constrain = require("constrain")
local SCALING = require("ui.scaling")

local CARD_ASPECT_RATIO = 1.4

local flux = require("flux")

local valuesmt = {__tostring = function(self) local new = {} for i,v in pairs(self) do new[i] = "("..tostring(v[1])..", "..tostring(v[2])..")" end return table.concat(new, ", ") end}

local tree; tree = element.make_new {
    name = "tree",

    cctr = function(self)
        local c = constrain {
            children = { self.card or error("no tree card") },
            ratio = CARD_ASPECT_RATIO,
            scaling = SCALING.CENTER,
        }

        self.slots = 1
        self.depth = 1

        self.main = c
        self.children = { c }
        self.cards = {}
        self.values = setmetatable({}, valuesmt)
    end,

    postcctr = function(self)
        self.card.on_flip = function()
            self:recalc()
            self.on_flip()
        end
        self:reset()
    end,

    on_recalc = function(self)
        self:do_recalc()
    end,

    base = {
        reset = function(self)
            self.slots = self.card.pivot.slots
            self:recalc()
        end,

        collapse = function(self, callback)
            self:recalc()

            local level = 0
            local levels = { [0] = { self } }

            repeat
                local l = {}

                for _,t in ipairs(levels[level]) do
                    for ti, v in pairs(t.cards) do
                        l[#l+1] = v
                    end
                end

                level = level+1
                levels[level] = l
            until #levels[level] == 0

            local function nextcollapse()
                level = level - 1

                if level == 0 then
                    callback(self.values[1])
                    return
                end

                local function center(e)
                    return e.abs_pos + 0.5 * e.abs_size
                end

                for i,v in ipairs(levels[level]) do
                    v.collapsing = true
                    if v.card.is_pivot_side then
                        v.parent.values[v.i] = v.card.pivot.play(v.values)
                    else
                        v.parent.values[v.i] = v.card.effect.play(v.card.effect)
                    end

                    local diff = center(v.parent) - center(v)
                    local anim = flux.to(v.position, 0.5, { xo = diff.x, yo = diff.y }):ease("circout")

                    if i == 1 then
                        anim:oncomplete(nextcollapse)
                    end
                end
            end

            self.collapsing = true
            nextcollapse()
        end,

        do_recalc = function(self)
            if self.collapsing then return end

            if self.card.is_pivot_side then
                local maxdepth = 1
                local breadth = 0

                for i=1,self.slots do
                    local e = self.cards[i+1]
                    breadth = breadth + (e and e.breadth or 1)
                end

                for i=1,self.slots do
                    local idx = i+1
                    local e = self.cards[idx]

                    if e then
                        maxdepth = math.max(maxdepth, e.depth)
                    else
                        e = group {
                            idx = idx,
                            children = {
                                sprite {
                                    size = dim2(0.5, 0, 0.5, 0),
                                    position = dim2(0.5, 0, 0.5, 0),
                                    anchor = vec2.new(0.5, 0.5),
                                    color = color.new(0, 0, 0, 0.8),

                                    image = assets.sprites.circle,
                                    scaling = SCALING.CENTER
                                }
                            }
                        }
                    end

                    e.size = dim2((e.breadth or 1)/breadth, 0, 1, 0)
                    e.position = dim2((i-1)/self.slots, 0, 0.9, 0)

                    e.i = i
                    self.children[idx] = e
                    e.parent = self
                end

                self.breadth = breadth
                self.depth = 1 + maxdepth
                self.constrain_mult = vec2.new(1, self.depth)
            else
                for i,_ in ipairs(self.children) do
                    if i ~= 1 then
                        self.children[i] = nil
                    end
                end
                self.breadth = 1
                self.depth = 1
                self.constrain_mult = vec2.new(1, 1)
            end
        end,

        fill_slot = function(self, idx, card)
            -- you cannot turn a pivot card which has a filled slot back to the effect side
            self.card.can_turn = false

            self.cards[idx] = tree {
                card = card,
                on_flip = self.on_flip
            }
        end
    }
}

return tree
