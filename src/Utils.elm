module Utils exposing (chunkLeft, isSubsetOf)

import List exposing (..)


chunkLeft : Int -> List a -> List (List a)
chunkLeft k xs =
    if k == 0 then
        [ [] ]

    else if k < 0 then
        []

    else if length xs > k then
        take k xs :: chunkLeft k (drop k xs)

    else
        [ xs ]


isSubsetOf : List a -> List a -> Bool
isSubsetOf list1 list2 =
    List.all
        (\el -> List.member el list1)
        list2
