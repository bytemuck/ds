return {
    id = 2,
    name = "Mux II",
    slots = 2,

    image = "pivot_2",
    effect = "x2",

    play = function(children)
        return { 2 * (children.attack[0] + children.attack[1]), 2 * (children.defense[0] + children.defense[1]) }
    end
}
