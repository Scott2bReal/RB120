## Initial thoughts

- A round has
  - Players
  - An outcome/winner

- A round does
  - Display game info

## How a Round might be used in RPSGame

- When the play method is called, display game info
- make a new `Round` object, assign to `round`? pass it the players which were
  instantiated when the `RPSGame` object is created
  
## Thoughts after implementation

I dont think the `Round` class was strictly necessary, but it was an interesting
exercise in mixing the `Displayable` module into more than one class. Both
`RPSGame` and `Round` are `Displayable`, and it worked pretty easily! I made
sure to keep my variable names consistent across the two classes, and
`Displayable` mixed right in.

The extraction of logic into the `Round` class meant that I was able to
eliminate a quite complicated `end_of_round` method from the `RPSGame` class. It
had contained a series of method calls to be executed upon completion of a
round. Now that some of that logic is extracted into `Round`, I was able to
replace the `end_of_round` method with a `play_a_round` method that is much
more simple
