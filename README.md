## elm-linear-direction


I think direction can be better expressed than in
- `foldr` and `foldl`: does `foldr` mean fold right? A quite unclear name
- `Array.slice`'s negative indices: `slice 0 -1` is handy! But you can't do `slice 2 -0`
- no `getr/l`, `setr/l`, ... but `foldr` and `foldl`?

This package's simple goal is allowing you to use the direction as an argument.

```elm
import LinearDirection exposing (LinearDirection(..))
import LinearDirection.Array as Array

Array.fromList [ "m", "l", "e" ]
    |> Array.fold LastToFirst (+) ""
--> "elm"
```

This has some neat advantages.

- You can deal with both directions at once
    ```elm
    import LinearDirection exposing (LinearDirection(..))
    import LinearDirection.Array as Array

    updateAt : Int -> LinearDirection -> (a -> a) -> Array a -> Array a
    updateAt index direction alter =
        Array.replaceAt index direction
            (alter (Array.at index direction))

    ```
- this also results in less clutter (e.g. one `fold` instead of `foldr` `foldl`)
