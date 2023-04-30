return {
    id = 1,
    name = "Mux I",
    slots = 2,

    image = "pivot_1",
    effect = "add",

    play = function(children)
        return { children.attack[0] + children.attack[1], children.defense[0] + children.defense[1] }
    end
}
