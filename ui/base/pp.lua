local nkeys = { [0] = true, recalcf = true, children = true, __internal = true, name = true }

local function eprint(element, sub)
    local meta = element[0]
    local s = { "  - "..(meta.name or "<unk>").." ("..tostring(element):gsub(".-: ", "").."):" }

    for k,v in pairs(element.__internal) do
        if not nkeys[k] then
            s[#s+1] = "    - " .. k .. ": " .. tostring(v)
        end
    end

    if element.children and #element.children > 0 then
        s[#s+1] = "    - children:"
        for i,v in ipairs(element.children) do
            local cs = eprint(v, true)
            for _,line in ipairs(cs) do
                s[#s+1] = "    "..line
            end
        end
    end

    if sub then
        return s
    else
        love.filesystem.write(element.name .. ".txt", table.concat(s, "\n"))
    end
end

return eprint
