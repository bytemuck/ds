return {
    id = 7,
    name = "Mux III",
    slots = 1,

    image = "pivot_3",
    effect = "x3",

    play = function(children)
            return { 3*(children[0] + children[0]), 3*(children[0] + children[0]) }
    end
}