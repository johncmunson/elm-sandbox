module Main exposing (..)

-- Press buttons to increment and decrement a counter.
--
-- Read how it works:
--   https://guide.elm-lang.org/architecture/buttons.html
--

import Browser
import Html exposing (Html, button, div, text)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Utils exposing (chunkLeft, isSubsetOf)



-- MAIN


main =
    Browser.sandbox { init = init, update = update, view = view }



-- MODEL


type Square
    = X
    | O


type alias Model =
    { numColumns : Int
    , entries : List (Maybe Square)
    , turn : Square
    }


init : Model
init =
    { numColumns = 3
    , entries = List.repeat 9 Nothing
    , turn = X
    }



-- UPDATE


type Msg
    = Play Int
    | Reset


updateEntries model position =
    List.indexedMap
        (\i entry ->
            if i == position then
                Just model.turn

            else
                entry
        )
        model.entries


updateTurn model =
    if model.turn == X then
        O

    else
        X


update : Msg -> Model -> Model
update msg model =
    case msg of
        Play position ->
            { model
                | entries = updateEntries model position
                , turn = updateTurn model
            }

        Reset ->
            init



-- VIEW


winningLines : List (List Int)
winningLines =
    [ [ 0, 1, 2 ]
    , [ 3, 4, 5 ]
    , [ 6, 7, 8 ]
    , [ 0, 3, 6 ]
    , [ 1, 4, 7 ]
    , [ 2, 5, 8 ]
    , [ 0, 4, 8 ]
    , [ 2, 4, 6 ]
    ]


type Winner
    = Square
    | Tie


renderWinnerText : List (Maybe Square) -> Html Msg
renderWinnerText entries =
    let
        entriesWithPositions =
            addPositionsToEntries entries

        exesAndOhs =
            List.filter (\( _, square ) -> square /= Nothing) entriesWithPositions

        partitionedExesAndOhs =
            List.partition
                (\( _, square ) ->
                    case square of
                        Just X ->
                            True

                        _ ->
                            False
                )
                exesAndOhs

        exes =
            Tuple.first partitionedExesAndOhs

        ohs =
            Tuple.second partitionedExesAndOhs

        xPositions =
            List.map Tuple.first exes

        oPositions =
            List.map Tuple.first ohs

        xWon =
            List.any
                (isSubsetOf xPositions)
                winningLines

        oWon =
            List.any
                (isSubsetOf oPositions)
                winningLines

        tieGame =
            List.length exesAndOhs == List.length entries
    in
    if xWon then
        text "X Won!"

    else if oWon then
        text "O Won!"

    else if tieGame then
        text "Tie Game!"

    else
        text "In Progress"


addPositionsToEntries : List (Maybe Square) -> List ( Int, Maybe Square )
addPositionsToEntries entries =
    List.indexedMap Tuple.pair entries


createRowsFromEntries : Int -> List ( Int, Maybe Square ) -> List (List ( Int, Maybe Square ))
createRowsFromEntries numColumns entries =
    chunkLeft numColumns entries


renderRow : List ( Int, Maybe Square ) -> Html Msg
renderRow row =
    div [ class "row" ]
        (List.map
            (\( position, square ) ->
                case square of
                    Nothing ->
                        button [ class "square", onClick (Play position) ] []

                    Just X ->
                        button [ class "square" ] [ text "x" ]

                    Just O ->
                        button [ class "square" ] [ text "o" ]
            )
            row
        )


view : Model -> Html Msg
view model =
    let
        rows =
            model.entries |> addPositionsToEntries |> createRowsFromEntries model.numColumns
    in
    div []
        [ div [ class "winner-text" ]
            [ renderWinnerText model.entries ]
        , div [ class "board" ]
            (List.map renderRow rows)
        , div [ class "reset" ]
            [ button [ onClick Reset ]
                [ text "Reset" ]
            ]
        ]
