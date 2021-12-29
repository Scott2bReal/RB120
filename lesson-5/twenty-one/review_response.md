Hi Jessica, thanks again for taking the time to review my code!

## User Experience / Gameplay

I spent quite a while (too long, probably 😅) trying to get that alternate card rendering to work well before I had much of any actual game logic in place. The cards themselves looked good, but I really wanted to print them side-by-side instead of just stacking on top of each other. I thought it would be a fun way to improve upon my card display from the procedural version of 21 (after refactoring), but I ended up giving up and going with what I did last time.

## Rubocop

The Rubocop error was a bit confusing, but overall a good experience as it gave me some practice with my version manager (rbenv) 🤣. I wanted to try to implement that default parameter value syntax since it was introduced in the TTT discussion material.

I played around with your suggestion of a `@hidden_card` instance variable for the dealer, and found it quite painless to implement! I added that attribute to the `Dealer`, made `Dealer#show_hidden_hand` private, and created a simple custom `Dealer#show_hand`:

```ruby
def show_hand
  hidden_card ? show_hidden_hand : super  
end
```

After that I just added a line each to `Game#reset_hands` and `Displayable#show_result` to manage the state of the `Dealer`'s `@hidden_card`. The result is a much simpler `Displayable#show_hands` method. I would agree with you that neither is a clearly "better" option, but I do think both are very clearly readable. I might give the original implementation a slight edge as it consolidates more of the logic regarding the dealer's hidden card status in one place 🤷

## Source Code

* I actually spent quite a while implementing `Hand` as a class instead of a module, as I thought that made the most sense from a real-world perspective (a hand of cards **is a** thing you can hold in your...hand...). My `Participant` class had a `@hand` instance variable, and the `Hand` class had its own `@cards` array. I got a basic game flow working with this structure, but found I was able to reduce the amount of method chaining (e.g. `player.hand.cards` becomes `player.cards`) when switching `Hand` to a module.

* I did also spend some time before submitting trying to remove the `Deck` dependency from the `Participant` class, but found it would take some serious restructuring of my code to get it to work. This was actually another major factor in making `Hand` a module, as that paired with the `Deck` dependency made it possible to be very flexible, concise, and clear in my `Hand` methods.

* Extracting the move choices to a constant took some effort, but I was able to make it happen! I decided to use a hash for the new `Game::TURN_OPTIONS` constant that looked like `{ '1' => 'hit', '2' => 'stay' }`. I then made use of `Joinable#join_list` to display those options to the user in different ways. I needed to create some helper methods to keep the line length down, but all in all I got the display looking exactly the same on the user end while adding some flexibility!

---

I really appreciate all the great suggestions, Jessica! As always, the review -> refactor process has been one of my very favorite steps in the process of putting this project together. I've tried to put a `# Refactor` comment where I made changes, and have included a link to a diff file in case anyone is interested in seeing the changes I made after refactoring!

[Original Submission](https://github.com/Scott2bReal/RB120/blob/main/lesson-5/twenty-one/twenty_one.rb)  
[Refactored Code](https://github.com/Scott2bReal/RB120/blob/main/lesson-5/twenty-one/twenty_one_refactored.rb)  
[Diff file](https://github.com/Scott2bReal/RB120/blob/main/lesson-5/twenty-one/refactor.diff)  

Thanks again Jessica, and I hope you have a happy New Year 🎉!
