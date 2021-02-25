## elm-linear-direction


I think direction can be better expressed than in
- `foldr` and `foldl`: does `foldr` mean fold right? Unclear in my opinion
- `Array.slice`'s negative indices: `slice 0 -1` is handy! But you can't do `slice 2 -0`
- Why is there no `getr/l`, `setr/l`, ... if there is `foldr` and `foldl`?
This package's simple goal is allowing you to use types containing the direction

This has some neat advantages.

Array.fold LastToFirst (+) 0

Array.fromList [ 1, 2, 3 ]
    |> putFrom FirstToLast
--> Array.fromList [ 2, 3, 1 ]

Array.fromList [ 1, 2, 3 ]
    |> putFrom LastToFirst
--> Array.fromList [ 3, 1, 2 ]


putFrom : Linear.Direction -> Array a -> Array a
putFrom direction =
    Array.removeAt 0 direction
        >> Array.insertAt 0 (Direction.opposite direction)

