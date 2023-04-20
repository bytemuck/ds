return {
    id = 2,
    name = "Mux II",
    slots = 2,

    image = "pivot_2",
    effect = "x2",

    play = function(children)
            return { 2*(children[0] + children[1]), 2*(children[0] + children[1]) }
    end
}