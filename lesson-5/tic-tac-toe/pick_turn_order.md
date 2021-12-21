# Player chooses turn order

## Problem

Right now the game defaults to having the player go first. I want the player to
choose which participant will go first.

## Examples

The game starts with a message asking the player to choose their marker. Maybe
after that message, another prompt will ask who the player wants to go first.
Offer options of human, computer, random. Maybe re-prompt after every game?
Every time `@current_player` is set, use the prompt method to set it.

## Data Structure

Make an array with the players to make the method selection logic easier

## Algorithm

- Prompt user to select who goes first (use numbers to make choice, easy
  validation)
