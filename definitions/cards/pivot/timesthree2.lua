return {
    id = 6,
    name = "Mux III",
    slots = 2,

    image = "pivot_2",
    effect = "x3",

    play = function(children)
            return { 3*(children[0] + children[1]), 3*(children[0] + children[1]) }
    end
}