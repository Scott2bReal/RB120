## History as a class

- Give it a class variable `@@record`
- Maybe a method that will update record
   - Would this be bad design? Would someone be able to edit the records since
    update_record will be a public method?

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
