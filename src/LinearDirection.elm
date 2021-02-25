module LinearDirection exposing (LinearDirection(..), opposite)

{-|

@docs LinearDirection, opposite

-}


{-| Either `FirstToLast` or `LastToFirst`.
You might also want to create aliases (e.g. forward and backward)
-}
type LinearDirection
    = FirstToLast
    | LastToFirst


opposite : LinearDirection -> LinearDirection
opposite direction =
    case direction of
        FirstToLast ->
            LastToFirst

        LastToFirst ->
            FirstToLast
