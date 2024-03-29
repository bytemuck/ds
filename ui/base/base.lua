-- Auteurs : Jonas Lépine

--[[
    The base code behind UI elements; size/position calculation, recursive rendering, etc.
]]

local vec2 = require("vec2")
local dim2 = require("dim2")

local base = {}

local recalc_props = { parent = true, size = true, position = true, anchor = true, children = true }

-- Calculation of the absolute (screen-space) pixel position/size of objects,
-- based on their relative (parent-space) properties.
function base.recalc(self, p)
    if not self.parent then
        -- If there is no parent, then the "scale" properties of the Dim2
        -- objects can be ignored, as they are multipliers on those properties
        -- in the parent object. The absolute values are as such exactly the 
        -- offsets from the Dim2 objects.
        self.abs_size = vec2.new(self.size.xo, self.size.yo)
        self.abs_pos = vec2.new(self.position.xo, self.position.yo)
        if p then
            print("no parent", "pos", self.abs_pos, "size", self.abs_size)
        end
    else
        local parent = self.parent
        if not (parent.abs_pos and parent.abs_size) then parent:recalc() return end

        local p_abs_pos = parent.abs_pos
        local p_abs_size = parent.abs_size

        local rel_pos = self.position
        local rel_size = self.size
        local anchor = self.anchor

        -- Size calculation
        local abs_size = vec2.new(
            rel_size.xo + (rel_size.xs * p_abs_size.x),
            rel_size.yo + (rel_size.ys * p_abs_size.y))
        self.abs_size = abs_size

        -- Position calculation
        self.abs_pos = vec2.new(
            p_abs_pos.x + rel_pos.xo + (rel_pos.xs * p_abs_size.x) - (anchor.x * abs_size.x),
            p_abs_pos.y + rel_pos.yo + (rel_pos.ys * p_abs_size.y) - (anchor.y * abs_size.y))

        if p then
            print(self)
            print("parent", "pos", p_abs_pos, "size", p_abs_size)
            print("rel", "pos", rel_pos, "size", rel_size, "anchor", anchor)
            print("abs", "pos", self.abs_pos, "size", abs_size)
        end

        if self[0].on_recalc then
            self[0].on_recalc(self)
        end
        if self.on_recalc then
            self.on_recalc(self)
        end
    end

    -- Recalculate the values for all of the children. As Dim2s are relative, a
    -- change in a parent may result in arbitrary changes to children of any
    -- depth level.
    if self.children then
        for _,child in ipairs(self.children) do
            child:recalc(p)
        end
    end
end

-- Creates a function to recalculate
function base.make_recalc(self)
    if not self.recalcf then
        self.recalcf = function()
            return base.recalc(self)
        end
    end
    return self.recalcf
end

-- Draw
function base.draw(self)
    -- callback to draw children, such that they can choose whether to draw chilren before or after 
    local go = function()
        if self.children then
            for _,child in ipairs(self.children) do
                child:draw()
            end
        end
    end

    if self[0] and self[0].draw then
        self[0].draw(self, go)
    else
        go()
    end
end

-- Update
function base.update(self, dt)
    if self[0] and self[0].update then
        self[0].update(self, dt)
    end

    if self.children then
        for _,child in ipairs(self.children) do
            child:update(dt)
        end
    end
end

-- Add a single child
function base.add_child(self, child)
    if not self.children then
        self.children = {}
    end

    self.children[#self.children+1] = child
    child.parent = self
    child:recalc()

    return self
end

-- Add multiple children
function base.add_children(self, children)
    if not self.children then
        self.children = {}
    end

    for _,v in ipairs(children) do
        self.children[#self.children+1] = v
        v.parent = self
        v:recalc()
    end

    return self
end

-- Clear children
function base.clear_children(self)
    self.children = {}
    self:recalc()
end

return {
    make_new = function(meta)
        return function(props, ...)
            local self = {
                [0] = meta,
                position = dim2(0, 0, 0, 0),
                size = dim2(1, 0, 1, 0),
                anchor = vec2.new(0, 0)
            }

            if meta.base then
                for k,v in pairs(meta.base) do
                    self[k] = v
                end
            end

            if props then
                for k,v in pairs(props) do
                    self[k] = v
                end
            end

            if meta.cctr then
                meta.cctr(self, ...)
            end

            self.__internal = self

            local mtself, recalcf; mtself = setmetatable({}, {
                __index = setmetatable(self, { __index = base }),

                __newindex = function(_, k, v)
                    self[k] = v

                    if recalc_props[k] then
                        if type(v[0]) == "table" then
                            for _,f in pairs(v[0]) do
                                if f == recalcf then
                                    mtself:recalc()
                                    return
                                end
                            end
                            v[0][#v[0]+1] = mtself:make_recalc()
                        end
                        if not self.size or not self.position then return end
                        mtself:recalc()
                    end
                end
            })

            local pos = self.position
            self.position = nil
            mtself.position = pos

            local size = self.size
            self.size = nil
            mtself.size = size

            if meta.postcctr then
                meta.postcctr(mtself, ...)
            end

            if self.children then
                for _,v in pairs(self.children) do
                    v.parent = mtself
                end
            end

            mtself:recalc()

            return mtself
        end
    end
}
