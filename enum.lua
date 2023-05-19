-- Auteurs : Jonas Lépine

return function(tbl)
    local new = {}

    for k,v in pairs(tbl) do
        new[k] = v
        new[v] = k
    end

    return setmetatable(new, {
        __index = function(self, k)
            error(k .. " is not a member of enum: " .. table.concat(tbl, ", "))
        end
    })
end