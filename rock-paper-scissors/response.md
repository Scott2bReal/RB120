Thanks so much for the thorough code review Ginni! I've refactored the game to
include some of your suggestions.

- Constant instead of method for inferior moves in individual move classes
  - Got a NameError due to uninitialized constant. Guessing that is because Ruby
    doesn't look too closely at method definitions until they come up in code,
    while when assigning values to a variable it does look at those values 
  - Had to edit `Move#beats?` slightly to accomodate the strings I wound up
  using

- Join or/Join and
  - Is it better to avoid repetition and have the user pass an argument, or is
    it better to have two separate methods with very specific names?
  - Implemented by having the user pass a `last_word` argument. Also refactored
    the conditional statement in favor of some in-line documentation (a comment
    describing the expected input). Will now be more flexible and reusable!

- Computer Personalities
  - Implemented by subclassing the different AIs from computer, as per
    suggestion. Each has their own `choose` method.
  - An unintended but fun consequence of the the way I implemented
    initialization of the computer player object is that the AI is no longer
    tied to the name of the computer. This ended up being more fun in my
    opinion, as part of the game becomes figuring out which AI you are playing!
