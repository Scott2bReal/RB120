## History as a class

- Give it a class variable `@@record`
- Maybe a method that will update record
   - Would this be bad design? Would someone be able to edit the records since
    update_record will be a public method? UPDATE: I made each `Record` object
    have a very limited public interface, where even the getter methods are set
    to private. The only publicly available behaviors of the `Record` class are
    to instantiate a `Record`, and to call `to_s` to read a predetermined string

### Basic Design

- A record has:
  -  entries
    - Each entry has
      - Players
      - moves
      - outcome
      - match winner, if any

- Maybe at the end of each round, I can create a new record object that will be
  stored in the history array of an RPSGame object

### Thoughts after Implementing History as a Class

I decided to create a class `Record`, and give the `RPSGame` class an attribute
`@history` which would store all records in an array. This array will be
populated with a new `Record` object each time a round finishes. This allowed me
to extract all of the logic behind generating a string describing the round into
the `Record` class, while keeping the logic of who wins a round contained inside
the `RPSGame` class.

In this draft, I also played around with limiting the interfaces of my classes.
I went through the program and looked at how the objects were interacting with
each other, and exposed only the necessary methods publicly to keep the
interface as simple as possible.

Before moving on to giving different 'personalities' to the computers, I am
going to take a crack at making a class `Round` to try to simplify the `RPSGame`
class.
