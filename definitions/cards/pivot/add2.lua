return {
    id = 1,
    name = "Mux I",
    slots = 2,

    image = "pivot_1",
    effect = "add",

    play = function(children)
            return { children[0] + children[1], children[0] + children[1] }
    end
}