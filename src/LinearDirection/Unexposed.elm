module LinearDirection.Unexposed exposing (toFirstToLast)

import LinearDirection exposing (LinearDirection(..))


toFirstToLast : Int -> LinearDirection -> { length : Int } -> Int
toFirstToLast n direction { length } =
    case direction of
        FirstToLast ->
            n

        LastToFirst ->
            length - 1 - n
