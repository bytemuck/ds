return {
    id = 7,
    name = "Mux III",
    slots = 1,

    image = "pivot_3",
    effect = "x3",

    play = function(children)
        return { 3 * (children[1][1] + children[2][1]), 3 * (children[1][2] + children[2][2]) }
    end
}
