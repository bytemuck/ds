return {
    id = 6,
    name = "Mux III",
    slots = 2,

    image = "pivot_2",
    effect = "x3",

    play = function(children)
        return { 3 * (children.attack[0] + children.attack[1]), 3 * (children.defense[0] + children.defense[1]) }
    end
}
