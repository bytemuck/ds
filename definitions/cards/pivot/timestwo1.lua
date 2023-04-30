return {
    id = 3,
    name = "Mux II",
    slots = 1,

    image = "pivot_2",
    effect = "x2",

    play = function(children)
        return { 2 * (children.attack[0] + children.attack[0]), 2 * (children.defense[0] + children.defense[0]) }
    end
}
