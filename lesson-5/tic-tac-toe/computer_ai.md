# Computer Defensive AI

Would love to have a `risky_squares` hash, with keys `human` and `computer` with
corresponding values which are arrays containing the squares which put players
at risk.

## Class distinctions, responsibilities
- Try to keep classes as generic as possible
  - `TTTGame` already has enough info to tell whether a square is at risk
  - `TTTGame` also has info (via `Board` about which player has marked a certain square
  
  - Who else needs to know about the risky squares? Just `TTTGame`?
   
## Methods

  - `TTTGame#risky_squares` should return list of at risk squares
  - `TTTGame#at_risk?` should return boolean given single square object
  - `Square#==` override to only look at `marker` of other square

`Board#at_risk?`
- 

`Board#risky_squares`
- For each unmarked square
  - If returned array of `DANGER_SQUARES[that square]` 
