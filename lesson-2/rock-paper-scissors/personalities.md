## Giving the Computers Personalities

### Initial Thoughts

- Make a class for each computer?
- Instead of just choosing a string name, choose one of the computer objects
  randomly
- The choose method for each computer will override the default computer one.
  Maybe leave one computer just choosing randomly?

### Implementation

I made a module called `Personable` which contains methods that will all return
a valid move. The differences between the methods will affect the choice of the
computer opponent. The names are very descriptive of what the choices will be.
`Computer#choose` now calls the private `choose_ai` method, which contains a
case statement that picks one of the ai methods from `Personable` based on the
computer's name. This was a very simple solution that only required editing
which was isolated to one class, and adding a simple module. It is very
customizable, easily maintained, and I think the function names are very clear.
