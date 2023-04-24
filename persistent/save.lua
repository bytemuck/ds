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
    end,

    shuffle_deck = function ()
        for i = #persistent.deck, 2, -1 do
            local j = math.random(i)
            persistent.deck[i], persistent.deck[j] = persistent.deck[j], persistent.deck[i]
        end
    end,

    draw_deck = function ()
        local pop = persistent.deck[#persistent.deck] -- Take last item.
        persistent.deck[#persistent.deck] = nil -- Set it to null
        persistent.deck = { pop, table.unpack(persistent.deck) } -- drawed card is now on the bottom
        return pop -- return drawed card
    end,

    push = function (id)
        persistent.deck[#persistent.deck] = id
    end
}