module Tile exposing (Tile, TileClass (..), GameClass (..), generateTile, generateRandomTile, generateRandomGameClass)

import Random

type GameClass
    = Shovel
    | GameTime
    | None

type TileClass
    = Empty
    | Wood
    | Fire
    | Seed
    | Wind
    | Water
    | Eye

gameClassCount : Int
gameClassCount = 4

tileClassCount : Int
tileClassCount = 5

intToTileClass : Int -> TileClass
intToTileClass i =
    case i of
        1 -> Empty
        2 -> Wood
        3 -> Fire
        4 -> Seed
        5 -> Wind
        6 -> Water
        7 -> Eye
        _ -> Empty

intToGameClass : Int -> GameClass
intToGameClass i =
    case i of
        1 -> Shovel
        2 -> GameTime
        _ -> None

type alias Tile = 
    { cssClass: String
    , gameClass: GameClass
    , tileClass: TileClass
    , visited: Bool
    }

generateTile : String -> GameClass -> TileClass -> Tile
generateTile name gameClass tileClass =
    { cssClass = name
    , gameClass = gameClass
    , tileClass = tileClass
    , visited = False
    }

generateRandomTile : Random.Generator TileClass
generateRandomTile = Random.map intToTileClass (Random.int 1 tileClassCount)

generateRandomGameClass : Random.Generator GameClass
generateRandomGameClass = Random.map intToGameClass (Random.int 1 gameClassCount)