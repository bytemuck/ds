return {
    id = 7,
    name = "Mux III",
    slots = 1,

    image = "pivot_3",
    effect = "x3",

    play = function(children)
        return { 3 * (children.attack[0] + children.attack[0]), 3 * (children.defense[0] + children.defense[0]) }
    end
}
