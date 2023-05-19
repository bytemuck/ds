-- Auteurs : Benjamin Breboin

return {
    id = 5,
    name = "Mux I",
    slots = 1,

    image = "pivot_2",
    effect = "x2",

    play = function(children)
        return { 2*children[1][1], 2*children[1][2] }
    end
}
