-- Auteurs : Benjamin Breboin

return {
    id = 2,
    name = "Mux II",
    slots = 2,

    image = "pivot_2",
    effect = "x2",

    play = function(children)
        return { 2 * (children[1][1] + children[2][1]), 2 * (children[1][2] + children[2][2]) }
    end
}
