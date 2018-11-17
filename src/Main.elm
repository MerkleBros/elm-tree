module Main exposing (main)

import Browser as Browser exposing (Document)
import String as String
import Dict exposing (Dict)
import List as List
import Html exposing (Html, a, button, div, h1, table, td, text, th, tr)
import Html.Attributes exposing (href)
import Html.Events exposing (onClick)
import Http
import Json.Decode as Decode exposing (Value)
import Json.Encode as Encode
import Random
import Result

import Restaurant exposing (Restaurant)
import Tile exposing (..)

-- Model

type alias Board
    = Dict Int Tile

type alias BoardList
    = List (List Tile)

initBoard : Board
initBoard = 
    Tile.generateTile "none" Tile.None Tile.Empty
        |> List.repeat 100 
        |> List.map2 Tuple.pair (List.range 1 100)
        |> Dict.fromList 

tileCount : Int
tileCount = 100

type alias Model =
    { restaurants : List Restaurant 
    , displayMessage : String
    , board : Board
    , tileCount : Int
    , treeTitle: String
    }

initModel : Model
initModel =
    { restaurants = []
    , displayMessage = "This is the first message" 
    , board = initBoard
    , tileCount = tileCount
    , treeTitle = "Tiny elm tree"
    }

generator : Random.Generator Int
generator = 
    Random.int 0 (messageDictLength - 1)

-- Update


type Msg
    = NoOp
    | GetRestaurants
    | UpdateRestaurants (Result Http.Error (List Restaurant))
    | GetRandomMessage
    | DisplayMessage Int
    | IncrementTileCount


messageOne : String
messageOne = "This is a string."

possibleMessages :  List (Int, String)
possibleMessages = 
    [
      (0,"Message 1")
    , (1,"Message 2") 
    , (2,"Message 3") 
    , (3,"Message 4")
    , (4,"Message 5")
    ]

messageDict : Dict Int String
messageDict = 
    Dict.fromList possibleMessages
messageDictLength = 5

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        GetRestaurants ->
            ( model, Restaurant.getRestaurants |> Http.send UpdateRestaurants )

        UpdateRestaurants result ->
            case result of
                Result.Ok restaurants ->
                    ( { model | restaurants = restaurants }, Cmd.none )

                Err error ->
                    ( model, Cmd.none )

        GetRandomMessage -> 
            ( model, Random.generate DisplayMessage (Random.int 0 (messageDictLength - 1)))

        DisplayMessage num ->
            ({ model | displayMessage = Maybe.withDefault "No message found" (Dict.get num messageDict)
                --Instead of withDefault, could do case selection below
                --let
                --    anon = Dict.get num messageDict
                --in
                --    case anon of 
                --        Just anonMessage -> anonMessage
                --        Nothing -> "No message found"
            }, Cmd.none)

        IncrementTileCount -> 
            ({ model | tileCount = tileCount + 1
            }, Cmd.none)


--randomMessage : Dict.Dict String String -> String
--randomMessage dict = 
--    let 
--        rand : Int
--        rand = 
--            Random.int 0 (messageDictLength - 1)
--    in
--        rand
        --0 dict ->
        --    Dict.get 0 dict 

-- View


view : Model -> Document Msg
view model =
    { title = "Elm Webpack Template"
    , body = renderBody model
    }


renderBody : Model -> List (Html Msg)
renderBody model =
    [ h1 [] [ text model.treeTitle]
    --, button [ onClick GetRestaurants ] [ text "Click ME!" ]
    --, button [ onClick GetRandomMessage ] [ text model.displayMessage]
    --, renderRestaurants model.restaurants
    , renderBoard model.board
    ]

renderBoard : Board -> Html Msg
renderBoard b = 
    div [ Html.Attributes.property 
                "className" (Encode.string "grid")
        ] 
        (Dict.toList b
            |> List.map (\t -> (tileToHtmlMsg <| (Tuple.first t)) (Tuple.second t) ))
            --div [] [text <| String.fromInt (Tuple.first t)]))

tileToHtmlMsg : Int -> Tile -> Html Msg
tileToHtmlMsg key t = 
    div [ Html.Attributes.property "className" (Encode.string t.cssClass)
        , Html.Attributes.property "className" (Encode.string "grid-element")
    ] [text <| String.fromInt key]

--renderTile : Tile -> Html Msg
--renderTile t = 
--   div [property "className" t.cssClass] 
--        (Dict.toList b
--        |> List.map (\t -> 
--            tileToHtmlMsg (Tuple.second t)))

    --let
    --    rows = 
    --        b
    --            |> 
            
    --in
            
    --if List.isEmpty b then
    --    div [] [text "Board is empty"]
    --else
    --    let
    --        rows = 
    --            b
    --                |> List.map (\r -> renderBoardRow r)
                
    --    in
    --        div [] rows

--renderBoardRow : List Tile -> Html Msg
--renderBoardRow row = 
--    if List.isEmpty row then 
--        div [] [text "Row is empty"]
--    else 
--        let 
--            tiles = 
--                row 
--                    |> List.map (\t -> renderTile t)
--        in
--            div [] tiles

--renderTile : Tile -> Html Msg
--renderTile tile =
--    div [] [text (String.fromInt tile.cssClass)]

renderRestaurants : List Restaurant -> Html Msg
renderRestaurants restaurants =
    if List.isEmpty restaurants then
        text ""

    else
        let
            rows =
                restaurants
                    |> List.map (\r -> renderRestaurant r)
                    |> List.append [ tableHeaderView ]
        in
        table [] rows


renderRestaurant : Restaurant -> Html Msg
renderRestaurant restaurant =
    tr []
        [ td [] [ text restaurant.name ]
        , td [] [ text restaurant.address ]
        , td [] [ a [ href restaurant.url ] [ text "Click Here" ] ]
        ]


tableHeaderView : Html Msg
tableHeaderView =
    tr []
        [ th [] [ text "Name" ]
        , th [] [ text "Address" ]
        , th [] [ text "Website" ]
        ]


-- Subscription


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


-- Main


init : Value -> ( Model, Cmd Msg )
init flags =
    ( initModel, Cmd.none )


main : Program Value Model Msg
main =
    -- Note, for more complex applications, Browser.application is recommended.
    Browser.document
        { init = init
        , subscriptions = subscriptions
        , update = update
        , view = view
        }
