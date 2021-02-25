module Try.N.Linear.Direction.Array exposing (at, fold, insertAt, removeAt, take)

import Array exposing (Array)
import Try.N.Linear exposing (Direction(..))
import Try.N.Linear.Direction as Direction


fold :
    Direction
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


insertAt : Int -> Direction -> a -> Array a -> Array a
insertAt index direction element array =
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


removeAt : Int -> Direction -> Array a -> Array a
removeAt index direction =
    \array ->
        let
            firstToLastIndex =
                Direction.toFirstToLast index
                    direction
                    { length = Array.length array }

            before =
                Array.slice 0 firstToLastIndex array

            after =
                Array.slice (firstToLastIndex + 1) (Array.length array) array
        in
        Array.append before after


at : Int -> Direction -> Array a -> Maybe a
at index direction =
    \array ->
        Array.get (Direction.toFirstToLast index direction { length = Array.length array }) array


take : Int -> Direction -> Array a -> Array a
take amount direction =
    \array ->
        case direction of
            FirstToLast ->
                array |> Array.slice 0 amount

            LastToFirst ->
                array
                    |> Array.slice -amount (Array.length array)
