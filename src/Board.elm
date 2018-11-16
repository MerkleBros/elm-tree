--module Board exposing (Board)
--import Tile exposing (Tile, TileClass, GameClass, generateTile, generateGameClass)

--type alias Board
--    = List (List Tile)

--initBoard : (_) -> Board
--initBoard _ = repeat 10 (repeat 10 (generate Tile.generateTile))

--type GameClass
--    = Shovel
--    | Wind
--    | GameTime
--    | None

--type TileClass
--    = Empty
--    | Tree
--    | Fire
--    | Seed
--    | Earth

--gameClassCount : Int
--gameClassCount = 4

--tileClassCount : Int
--tileClassCount = 5

--intToTileClass : Int -> TileClass
--intToTileClass i =
--    case i of
--        1 -> Empty
--        2 -> Tree
--        3 -> Fire
--        4 -> Seed
--        5 -> Earth
--        _ -> Empty

--intToGameClass : Int -> GameClass
--intToGameClass i =
--    case i of
--        1 -> Shovel
--        2 -> Wind
--        3 -> GameTime
--        _ -> None

--type alias Tile = 
--    { id: Int
--    , cssClass: String
--    , gameClass: GameClass
--    , tileClass: TileClass
--    }

--generateTile : Random.Generator TileClass
--generateTile = Random.map intToTileClass (Random.int 1 tileClassCount)

--generateGameClass : Random.Generator GameClass
--generateGameClass = Random.map intToGameClass (Random.int 1 gameClassCount)