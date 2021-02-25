module Linear.Direction exposing (opposite, toFirstToLast)

import Linear exposing (Direction(..))


opposite : Direction -> Direction
opposite direction =
    case direction of
        FirstToLast ->
            LastToFirst

        LastToFirst ->
            FirstToLast


toFirstToLast : Int -> Direction -> { length : Int } -> Int
toFirstToLast n direction length =
    case direction of
        FirstToLast ->
            n

        LastToFirst ->
            .length length - 1 - n
