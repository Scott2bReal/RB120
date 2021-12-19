## Creating a distinct class for each move

At first I thought that creating a class for each move was a bit excessive, but
it turns out that it made for some good code! I had each move type inherit from
the general `Move` class, and ended up just defining an `inferior_pairs` method
for each subclass

### Initial implementation

When I first defined the classes for each move, I gave them each their own
`beats?` method. This ended not being very DRY, so I was able to extract the
`beats` method into the `Move` class, and just define an `inferior_pairs` method
for each of the subclasses. I really like how this turned out; the
`Move#beats?` method reads very intuitively, and the subclass definitions are
simple and easy to understand

### Making the rest of the code more flexible

After implementing the subclasses for each move I took a look through the rest
of the code, and found places where I could remove some hard-coded values and
messages to make future modifications/additions easier!

#### `Player` class

I initially tried to include the `POSSIBLE_MOVES` constant in the `Move` class,
but found that difficult to implement because I wanted the array to contain the
class names. Because the subclasses need to be defined after the superclass,
errors were thrown whenever I tried to reference `POSSIBLE_MOVES`. If it is
placed within the `Player` class, however, those class names are defined and
available. This arguably makes even more sense, as the `POSSIBLE_MOVES` constant
describes moves which are available for the player to make!

I also broke up some of the methods such as `set_name` and `choose` so that the
validation, messages, and prompts are easy to find and edit outside of the logic
of the methods themselves.

Improving the flexibility of the `Player` class would allow for even more move
options to be added in the future with minimal changes beyond editing the
`Player::POSSIBLE_MOVES` constant, and creating new classes for those moves
using the template of the existing move subclasses
