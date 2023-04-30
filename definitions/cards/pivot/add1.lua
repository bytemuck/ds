return {
    id = 5,
    name = "Mux I",
    slots = 1,

    image = "pivot_2",
    effect = "add",

    play = function(children)
        return { children.attack[0] + children.attack[0], children.defense[0] + children.defense[0] }
    end
}
