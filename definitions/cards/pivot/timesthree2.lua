-- Auteurs : Benjamin Breboin

return {
    id = 6,
    name = "Mux III",
    slots = 2,

    image = "pivot_2",
    effect = "x3",

    play = function(children)
        return { 3 * (children[1][1] + children[2][1]), 3 * (children[1][2] + children[2][2]) }
    end
}
