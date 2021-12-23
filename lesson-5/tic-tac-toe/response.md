Thanks so much for the code review Jessica! I've made some revisions based on
your feedback.

## User Experience/Gameplay

* Oops, forgot to `include Joinable` in the `Human` class! I neglected to test
  that after extracting `join_list` to a module. Always a good reminder to test
  often!

* As per your suggestion, I've made entering `info` to view the game info
  case-insensitive.
  
## Source Code

* Your point regarding the `Verifiable` and `Promptable` modules is well taken!
  Those modules were a bit of an experiment to try to create methods for
  general re-use across programs. Since I just end up copy/pasting the module
  into a new program anway, I suppose it's not really saving me much work!
  Reading through my code after only a little time away, I'm realizing I may
  have gone a bit overboard extracting simple messages to methods in modules.
  The majority of them are only called in one place, and are specific to a
  specific class/object! The methods in `TTTGame` do read very cleanly as a
  result, but I wonder if working on the code in the future would be a hassle
  with all the jumping around to find messages...

* I spent some time trying to impelement your suggestion of storing the
  `choose_first_turn` options in a constant. I defined this constant...
  
  ```ruby
  FIRST_TURN_CHOICES = {
  '1' => human,
  '2' => computer,
  '3' => [human, computer].sample
  }
  ```
  
  ...and changed the break condition in the loop in `choose_first_turn` to
  read...
  
  ```ruby
  break if FIRST_TURN_CHOICES.keys.include?(answer)
  ```
  
 ...but ran into trouble, as the getter methods for `human` and `computer` were
 not yet defined when the constant assignment was evaluated. I tried to move
 the constant assignment to after the getter method definitions, but this didn't
 solve the problem. I tried redefining the constant as...
 
 ```ruby
 FIRST_TURN_CHOICES = {
 '1' => 'human',
 '2' => 'computer',
 '3' => %w(human computer).sample
 }
 ```
 
 ...but this caused issues elsewhere where the code depended on
 `@current_player` being assigned to one of the player objects. I refactored
 references to `@current_player` to accommodate it being assigned to a `String`
 rather than a `Player` subclass object, which introduced some complexity to 
 `TTTGame#players_take_turns`. I extracted that to the following method...
 
```ruby
def current_player_scores_a_point
  current_player == 'human' ? human.scores_a_point : computer.scores_a_point
end
```

...and it worked! It was an engaging exercise to refactor this part of the
program. Definitely made me take a closer look at how/when constants are
evaluated!

Again, I really appreciate the time and effort you (and all the TA's) put into
these code reviews! I always come away with a much deeper understanding of my
own code, a better idea of what concepts to focus on, and a more clear picture
of my blind spots and weak areas. I've uploaded my refactored code [here]
