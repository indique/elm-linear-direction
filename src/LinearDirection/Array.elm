module LinearDirection.Array exposing (fold, take, at, replaceAt, removeAt, insertAt)

{-| `Array` operations that can be appled in either direction.

@docs fold, take, at, replaceAt, removeAt, insertAt

-}

import Array exposing (Array)
import LinearDirection exposing (LinearDirection(..))
import LinearDirection.Unexposed exposing (toFirstToLast)


{-| Reduce an `Array` in a direction.

    Array.fromList [ "elm", "wood" ]

-}
fold :
    LinearDirection
    -> (element -> result -> result)
    -> result
    -> Array element
    -> result
fold direction reduce initial =
    case direction of
        FirstToLast ->
            Array.foldl reduce initial

        LastToFirst ->
            Array.foldr reduce initial


{-| Put an element in an `Array` at a given index in a direction.

    acd =
        Array.fromList [ 'a', 'c', 'd' ]

    acd |> Array.insertAt 1 FirstToLast 'b'
    --> Array.fromList [ 'a', 'b', 'c', 'd' ]
    acd |> Array.insertAt 2 LastToFirst 'b'
    --> Array.fromList [ 'a', 'b', 'c', 'd' ]

If the index is out of bounds, nothing gets inserted.

    acd |> Array.insertAt -1 'b'
    --> acd
    acd |> Array.insertAt 10 'b'
    --> acd

-}
insertAt : Int -> LinearDirection -> a -> Array a -> Array a
insertAt index direction element array =
    case index >= 0 && index <= Array.length array of
        True ->
            let
                indexAfterElement =
                    case direction of
                        FirstToLast ->
                            index

                        LastToFirst ->
                            Array.length array - index

                before =
                    Array.slice 0 indexAfterElement array

                after =
                    Array.slice indexAfterElement (Array.length array) array
            in
            Array.append (Array.push element before) after

        False ->
            array


{-| Kick an element out of an `Array` at a given index in a direction.

    Array.fromList [ 'a', 'a', 'b' ]
        |> Array.removeAt 1 FirstToLast
    --> Array.fromList [ 'a', 'b', 'c', 'd' ]
    Array.fromList [ 'a', 'b', 'c', 'd' ]
        |> Array.removeAt 0 LastToFirst
    --> Array.fromList [ 'a', 'b', 'c' ]

If the index is out of bounds, the `Array` is unaltered.

    Array.fromList [ 'a', 'a', 'b' ]
        |> Array.removeAt -1 FirstToLast
    --> Array.fromList [ 'a', 'a', 'b' ]

-}
removeAt : Int -> LinearDirection -> Array a -> Array a
removeAt index direction array =
    case index >= 0 && index <= Array.length array of
        True ->
            let
                firstToLastIndex =
                    LinearDirection.toFirstToLast index
                        direction
                        { length = Array.length array }

                before =
                    Array.slice 0 firstToLastIndex array

                after =
                    Array.slice (firstToLastIndex + 1) (Array.length array) array
            in
            Array.append before after

        False ->
            array


{-| Return `Just` the element at an index in a direction.

    Array.fromList [ "lose", "win", "lose" ]
        |> Array.at 0 LastToFirst
    --> Just "lose"

    Array.fromList [ 1, 2, 3 ]
        |> Array.at 0 FirstToLast
    --> Just "lose"

If the index is out of range, return `Nothing`.

    Array.fromList [ 1, 2, 3 ]
        |> Array.at -1
    --> Nothing

-}
at : Int -> LinearDirection -> Array a -> Maybe a
at index direction array =
    Array.get
        (LinearDirection.toFirstToLast index
            direction
            { length = Array.length array }
        )
        array


{-| Set the element at an index in a direction.

    Array.fromList [ "I", "am", "ok" ]
        |> Array.replaceAt 2 FirstToLast "confusion"
    --> Array.fromList [ "I", "am", "confusion" ]

    Array.fromList [ "I", "am", "ok" ]
        |> Array.replaceAt 1 LastToFirst "feel"
    --> Array.fromList [ "I", "feel", "ok" ]

If the index is out of range, the array is unaltered.

    Array.fromList [ "I", "am", "ok" ]
        |> Array.replaceAt -1 FirstToLast "is"
    --> Array.fromList [ "I", "am", "ok" ]

-}
replaceAt :
    Int
    -> LinearDirection
    -> element
    -> Array element
    -> Array element
replaceAt index direction new array =
    Array.set
        (LinearDirection.toFirstToLast index
            direction
            { length = Array.length array }
        )
        new
        array


{-| A certain number of elements from one side.

    Array.fromList [ 1, 2, 3, 4, 5, 6 ]
        |> Array.take 4 FirstToLast
        |> Array.take 2 LastToFirst
    --> Array.fromList [ 3, 4 ]

    Array.fromList [ 1, 2, 3 ]
        |> Array.take 100
    --> Array.fromList [ 1, 2, 3 ]

-}
take : Int -> LinearDirection -> Array a -> Array a
take amount direction array =
    case direction of
        FirstToLast ->
            Array.slice 0 amount array

        LastToFirst ->
            Array.slice -amount (Array.length array) array
