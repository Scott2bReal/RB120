# Player Chooses X or O

## Problem

Right now player and computer are assigned markers using constants. I would like
to ask the human upon starting the game, which marker (X or O) they would like
to use.

## Examples

Game starts, welcome message is displayed and something like "Before we begin
which marker would you like to use? (X or O)? Some easy input validation
(accept upper or lower case, but marker will always be upcased). For the rest of
the, the player will use that marker and the computer will use the other

## Data Structure

Using a constant right now. Might want to make just one constant which is an
array like `['X', 'O']`.

## Algorithm

- Player chooses which marker
  - Assign player marker based on choice
  - Assign computer other marker in array
