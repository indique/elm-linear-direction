module LinearDirection.Unexposed exposing (toFirstToLast)


toFirstToLast : Int -> LinearDirection -> { length : Int } -> Int
toFirstToLast n direction { length } =
    case direction of
        FirstToLast ->
            n

        LastToFirst ->
            length - 1 - n
