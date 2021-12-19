## Adding Lizard and Spock to RPS

I immediately reached for a hash to organize the rules of who beats who this
time because that's what I used in the previous RPS project. It ended up working
out really well, after some initial difficulty!

Initially I tried to model my `>` and `<` methods after the example methods from
the walk-thru, and was able to get them working. However, the 'perceived
complexity' cop was throwing an alert. With a night's sleep and some examination
of the nature of the data structure I was able to simplify each method to a
single line!

The `VALUES` constant is now assigned to a hash, whose keys are strings
representing each of the 5 possible moves, and whose values are arrays
containing strings representing the moves that the key move beats.

This simplified the `>` and `<` in that I was able to just check if the array at
the key corresponding to one player's move contained the other player's move. If
neither were true, then the result of the round must be a tie!

I only needed to change `Human#choose` to reflect the additional choices, and as
a result needed to change my `Human#translate_choice` method to also reflect
those options. The `Computer#choose` method still worked as it was!
