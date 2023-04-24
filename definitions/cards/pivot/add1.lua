return {
    id = 5,
    name = "Mux I",
    slots = 1,

    image = "pivot_2",
    effect = "add",

    play = function(children)
            return { children[0] + children[0], children[0] + children[0] }
    end
}