### Grow! An Elm Minesweeping Game
![license](https://img.shields.io/github/license/mashape/apistatus.svg)

### About
A Minesweeper style game where the player uncovers tiles in search of wood and seeds. 

Collect seeds to advance to the next level, or continue revealing to grow your elm sapling. 

But watch out! If you uncover a fire tile it will burn your little tree to the ground!

### Concepts
Each level starts with all tiles covered. 

The player clicks on tiles to uncover them.

The player can discover 7 types of tiles
1. 'Seeds'  - Players need a certain number of seeds to advance to the next level
2. 'Wood'   - Players use wood to grow their elm tree and get more points
3. 'Wind'   - Players can use wind to put out fires in a given tile area
4. 'Vision' - Players can use vision to get a sneak peek at tiles
5. 'Water'  - Players sacrifice a water when they uncover a Fire tile.
6. 'Fire'   - The player loses if they uncover a Fire tile without any Water tiles to put the fire out.
7. 'Empty'  - Nothing happens :)

The player may advance to the next level when they have collected enough seeds.

### Installation
1. Clone or fork the repo
1. Install [Elm](https://guide.elm-lang.org/install.html) if you do not have it
1. Install [NodeJS](https://nodejs.org/en/download/) if you do not have it
1. Install the node dependencies by running `npm install`
1. Build the front-end by running `npm run build` (Webpack will watch for any changes and rebuild automatically)
1. Start the server by running `npm start` and go to [`http://localhost:3000`](http://localhost:3000)

### Deployment
1. `package.json` contains a script to deploy to [Heroku](https://www.heroku.com) using Webpack in production mode
