local persistent = require("persistent")
local dkjson = require("dkjson")

local savepath = "savegame.json"

return {
    save = function()
        local content = love.filesystem.read(savepath)
        if content then
            local decoded = dkjson.decode(content)
            if type(decoded) == "table" then
                persistent = decoded
            end
        end
    end,

    load = function()
        local encoded = dkjson.encode(persistent, { indent = true })
        if type(encoded) == "string" then
            love.filesystem.write(savepath, encoded)
        end
    end
}