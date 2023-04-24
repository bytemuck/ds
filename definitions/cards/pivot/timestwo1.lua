return {
    id = 3,
    name = "Mux II",
    slots = 1,

    image = "pivot_2",
    effect = "x2",

    play = function(children)
            return { 2*(children[0] + children[0]), 2*(children[0] + children[0]) }
    end
}