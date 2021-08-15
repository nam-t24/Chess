# Chess
### Chess game project using Ruby for App Academy Full Stack Bootcamp
<img src="images/Starting Board.png" width="600">

## Installation
1. Clone repo
2. Make sure system is able to run ruby
3. run `gem install colorize`
4. To start, run the game file with the command `ruby game.rb`
5. Play the game against yourself or with a friend using the corresponding keys!

## Features
- Uses cursor input from keyboard to make moves
  - WASD/arrow keys to move cursor to move to position
  - Enter/space keys to select position
  - Initial position selection is marked with a cyan color, Final position selection is marked with a magenta color
- Toggle move assist for selected piece using tab key (For those unfamiliar with chess)
 <p align="center">
  <img src="images/Toggle Move Assist.png" width="600">
 </p>

- Use esc key to save current game (done through YAML)
  - To run saved game, use command `ruby game.rb {saved file name}` (e.g., `ruby game.rb saved`)
