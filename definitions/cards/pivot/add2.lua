-- Auteurs : Benjamin Breboin

return {
    id = 1,
    name = "Mux I",
    slots = 2,

    image = "pivot_1",
    effect = "add",

    play = function(children)
        return { children[1][1] + children[2][1], children[1][2] + children[2][2] }
    end
}
