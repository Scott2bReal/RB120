## Display Instructions

### Problem

When the player is asked to choose a square the square numbers aren't shown.
This was a purposeful decision as when the numbers are displayed the board
looks too cluttered. Once the numbers are learned well it is a better playing
experience without displaying the numbers.

I want the user to be able to type 'info' when prompted for a square, which will
display the rules of the game, and a board with the numbers included.

### Examples

When user is prompted to select a square, also include a prompt that lets them
know they can type 'info' for instructions. This will display the board with the
positions in the squares, as well as a rundown of the rules of tic tac toe. When
they press enter they will be returned to the game screen where they left off.

### Data Structure

Give each square a `@position`, how I implemented it before (if i can remember)
Maybe a constant in `TTTGame` with a rules description.

### Algorithm

- When human is prompted for choice, also ask if they want to view info
- If they pick info, execute game info display
  - display game info, enter to continue prompt
  - after enter pressed, clear_screen_and_display_board, back to human chooses
