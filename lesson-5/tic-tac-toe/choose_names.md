## Choose Names

### Problem

Right now computer is just "Computer" and player is just... "you". Will need to
alter the scoreboard layout to account for dynamically sized player name. Player
should be able to pick any name that is not a possible computer name.

### Examples

After player chooses marker, they will enter a name. Name should be validated to
make sure isn't an empty string and isn't one of the possible computer names

The computer will choose one of a set of names, probably defined in a constant.

### Data Structure

Probably use an array of computer names stored in a constant

### Algorithm

Prompt player for name (define in `Promptable`)
Validate player entry (probably defined in `TTTGame`

Computer chooses name from possible names array at random
