return {
    id = 4,
    name = "Mux IV",
    slots = 1,

    image = "pivot_3",
    effect = "x4",

    play = function(children)
        return { 4 * (children.attack[0] + children.attack[0]), 4 * (children.defense[0] + children.defense[0]) }
    end
}
