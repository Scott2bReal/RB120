# Create an object-oriented number guessing class for numbers in the range 1 to
# 100, with a limit of 7 guesses per game. The game should play like this:

class GuessingGame
  def initialize(low, high)
    @range = (low..high)
    @guess_limit = Math.log2(@range.size).to_i + 1
    @guesses_made = 0
    new_number
  end

  def play
    loop do
      display_remaining_guesses
      player_guesses
      display_guess_result
      break if guessed_it? || no_more_guesses?
    end

    display_final_result
    reset
  end

  attr_reader :range

  private

  attr_accessor :guess, :guesses_made
  attr_reader :player, :number, :guess_limit

  def display_remaining_guesses
    if guess_limit - guesses_made > 1
      puts "\nYou have #{guess_limit - guesses_made} guesses remaining."
    else
      puts "\nYou have 1 guess remaining."
    end
  end

  def player_guesses
    answer = nil

    loop do
      display_guess_prompt
      answer = gets.chomp
      break if valid_guess?(answer)
      puts "Invalid guess."
    end

    @guesses_made += 1
    self.guess = answer.to_i
  end

  def display_guess_prompt
    puts "Enter a nuber between #{range.min} and #{range.max}"
  end

  def valid_guess?(answer)
    range.cover?(answer.to_i)
  end

  def display_guess_result
    case guess <=> number
    when -1 then puts "Your guess is too low"
    when 0 then puts "That's it!"
    when 1 then puts "Your guess is too high"
    end
  end

  def guessed_it?
    guess == number
  end

  def no_more_guesses?
    guess_limit - guesses_made == 0
  end

  def display_final_result
    if guessed_it?
      puts 'You won!'
    else
      puts 'You ran out of guesses! You lost!'
    end
  end

  def reset
    self.guesses_made = 0
    new_number
  end

  def new_number
    @number = rand(range)
  end
end

game = GuessingGame.new(501, 1500)
game.play

game.play

# You have 7 guesses remaining.
# Enter a number between 1 and 100: 104
# Invalid guess. Enter a number between 1 and 100: 50
# Your guess is too low.

# You have 6 guesses remaining.
# Enter a number between 1 and 100: 75
# Your guess is too low.

# You have 5 guesses remaining.
# Enter a number between 1 and 100: 85
# Your guess is too high.

# You have 4 guesses remaining.
# Enter a number between 1 and 100: 0
# Invalid guess. Enter a number between 1 and 100: 80

# You have 3 guesses remaining.
# Enter a number between 1 and 100: 81
# That's the number!

# You won!

# game.play

# You have 7 guesses remaining.
# Enter a number between 1 and 100: 50
# Your guess is too high.

# You have 6 guesses remaining.
# Enter a number between 1 and 100: 25
# Your guess is too low.

# You have 5 guesses remaining.
# Enter a number between 1 and 100: 37
# Your guess is too high.

# You have 4 guesses remaining.
# Enter a number between 1 and 100: 31
# Your guess is too low.

# You have 3 guesses remaining.
# Enter a number between 1 and 100: 34
# Your guess is too high.

# You have 2 guesses remaining.
# Enter a number between 1 and 100: 32
# Your guess is too low.

# You have 1 guesses remaining.
# Enter a number between 1 and 100: 32
# Your guess is too low.

# You have no more guesses. You lost!
