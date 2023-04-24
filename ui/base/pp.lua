local function eprint(element, sub)
    local meta = element[0]
    local s = { meta.name or "<unk>" }

    for k,v in pairs(element) do
        if k ~= 0 and k ~= "children" then
            s[#s+1] = k .. ": " .. tostring(v)
        end
    end

    if element.children and #element.children > 0 then
        s[#s+1] = " children:"
        for i,v in ipairs(element.children) do
            local cs = eprint(v, true)
            for _,line in ipairs(cs) do
                s[#s+1] = "  "..line
            end
        end
    end

    if sub then
        return s
    else
        print(table.concat(s, "\n"))
    end
end

return eprint
