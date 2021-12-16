Thanks so much for the thorough code review Ginni! These code reviews are always
so helpful in solidifying my understanding of the concepts in each lesson!I've
refactored the game to implement your suggestions, and written about my changes
and included links to the original and refactored code for anyone interested!

- [Original Submission](https://github.com/Scott2bReal/RB120/blob/main/rock-paper-scissors/rps_latest.rb)
- [Refactor](https://github.com/Scott2bReal/RB120/blob/main/rock-paper-scissors/rps_refactor.rb)

## Input Validation

I thought I had accounted for this, but never tested it! I made `Human#valid_choice?` more specific by calling `to_a` on the range of numbers, and `to_f` on the user's input. I also made the `invalid_move_choice_method` mor specific by having it exactly list the valid choices.

```ruby
  def valid_choice?(answer)
    (1..Player::POSSIBLE_MOVES.size).include?(answer.to_i)
  end
```

became...

```ruby
  def valid_choice?(answer)
    (1..Player::POSSIBLE_MOVES.size).to_a.include?(answer.to_f)
  end
```

## Constant vs. method to define 'inferior moves'

Your suggestion to use a constant instead of a method definitely makes more
sense!

```ruby
class Rock < Move
  def inferior_moves
    [Scissors, Lizard]
  end
end
```

And after the refactor...

```ruby
class Rock < Move
  INFERIOR_MOVES = ['Scissors', 'Lizard']
end
```

I had actually had tried using constant at first, but because I was trying
to directly reference the class names, Ruby would throw a `NameError` due to
uninitialized constants. I used the method instead of a constant to delay the
evaluation of, for example, `Lizard`, until after it had been defined. 
I was able to implement your solution by populating the inferior moves arrays
with strings instead, and with a slight tweak to `Move#beats?`, shown below...

```ruby
def beats?(other_move)
  inferior_moves.include?(other_move.class)
end
```

became...

```ruby
def beats?(other_move)
  self.class::INFERIOR_MOVES.include?(other_move.class.to_s)
end
```

## Refactoring `Joinable`

The repetition in my original `join_or`/`join_and` methods was actually a
conscious decision. I decided to sacrifice some DRYness in favor of making
specific and memorably named methods that were simple to use. After refactoring
as per your suggestion, however, I do like the result much more! The resulting
`join_list` method ended up being something that seems very flexible and
reusable! I included some 'documentation' as an inline comment to help guide a
hypothetical user in the usage of the method

```ruby
def join_list(list, last_word) # list should be an array size > 1
  if list.size > 2
    "#{list[0..-2].join(', ')}, #{last_word} #{list[-1]}"
  elsif list.size == 2
    "#{list[0]} #{last_word} #{list[1]}"
  end
end
```

This one made me wonder, **can it sometimes be better to make separate methods
with very similar functionality and some repetition in order to simplify the
end-user interface, or should DRYness be considered over all else?** In this
case the repeptition was unecessary, but maybe down the line with more
complicated or esoteric functionalities it could be useful?

## Computer Personalities

This was the refactor that took the most effort, and I am pleased with the
results! Your point regarding the lack of a re-use case for the `Personable`
module is well taken. I organized the code that way to try to make it flexible
and easily modifiable, with my imagined workflow being that to add a new AI, a
method could be added to `Personable` and a new `when` expression could be added
to the `case` statement in `Computer#choose_ai`. I think your suggestion of
using classes and inheritance does make more sense, though. While working out
how to implement the subclassing of the different personalites you suggested, I
discovered that I could de-couple the personality from the computer name, which
would add a fun element to the game. Now part of the strategy is figuring out
which AI you're playing against!

Defining the new subclasses was fairly simple, but deciding how to integrate
them into the existing game flow did take some thought. I ended up deciding that
when the `RPSGame` object was initialized, I would tell it to instantiate one of
the AI classes at random. I did this by repurposing the `choose_ai` method name
from my previous version that contained the case statement, and turning it into
a class method. Instead of a case statement assigning AIs to computer names, it
simply returns an AI subclass at random!

## Separate `Round` class

The extraction of a round into its own class was actually a bit of an
experiment! Sort of a "see if I can get it to work" kind of thing. My original
working version of the game was implemented just like your suggestion! However,
I noticed that my `RPSGame` class was getting relatively complicated, and that
the implementation of a "round" was fairly involved. I had an `end_of_round`
method inside of `RPSGame` that called a series of methods from `RPSGame` and
`Displayable` in order to reduce the complexity of `RPSGame#play`.

Thanks again for your review! I'm looking forward to continuing to dive into OOP
