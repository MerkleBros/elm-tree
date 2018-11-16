module Tile exposing (Tile, TileClass (..), GameClass (..), generateTile, generateRandomTile, generateRandomGameClass)

import Random

type GameClass
    = Shovel
    | Wind
    | GameTime
    | None

type TileClass
    = Empty
    | Tree
    | Fire
    | Seed
    | Earth

gameClassCount : Int
gameClassCount = 4

tileClassCount : Int
tileClassCount = 5

intToTileClass : Int -> TileClass
intToTileClass i =
    case i of
        1 -> Empty
        2 -> Tree
        3 -> Fire
        4 -> Seed
        5 -> Earth
        _ -> Empty

intToGameClass : Int -> GameClass
intToGameClass i =
    case i of
        1 -> Shovel
        2 -> Wind
        3 -> GameTime
        _ -> None

type alias Tile = 
    { id: Int
    , cssClass: String
    , gameClass: GameClass
    , tileClass: TileClass
    }

generateTile : Int -> String -> GameClass -> TileClass -> Tile
generateTile id name gameClass tileClass =
    { id = id
    , cssClass = name
    , gameClass = gameClass
    , tileClass = tileClass
    }

generateRandomTile : Random.Generator TileClass
generateRandomTile = Random.map intToTileClass (Random.int 1 tileClassCount)

generateRandomGameClass : Random.Generator GameClass
generateRandomGameClass = Random.map intToGameClass (Random.int 1 gameClassCount)