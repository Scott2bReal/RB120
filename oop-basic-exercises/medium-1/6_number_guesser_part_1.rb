# Create an object-oriented number guessing class for numbers in the range 1 to
# 100, with a limit of 7 guesses per game. The game should play like this:

class Player
  def initialize
    @guesses_made = 0
  end

  attr_reader :guesses_made

  def guess
    answer = nil

    loop do
      display_guess_prompt
      answer = gets.chomp
      break if valid_guess?(answer)
      puts "Invalid guess."
    end

    @guesses_made += 1
    answer.to_i
  end

  def reset
    self.guesses_made = 0
  end

  private

  attr_writer :guesses_made

  def display_guess_prompt
    print "Enter a number between 1 and 100: "
  end

  def valid_guess?(answer)
    GuessingGame::RANGE.include?(answer.to_i)
  end
end

class GuessingGame
  GUESS_LIMIT = 7
  RANGE = (1..100)

  def initialize
    @player = Player.new
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

  private

  attr_accessor :guess
  attr_reader :player, :number

  def display_remaining_guesses
    puts "\nYou have #{GUESS_LIMIT - player.guesses_made} guesses remaining."
  end

  def player_guesses
    @guess = player.guess
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
    GUESS_LIMIT - player.guesses_made == 0
  end

  def display_final_result
    if guessed_it?
      puts 'You won!'
    else
      puts 'You ran out of guesses! You lost!'
    end
  end

  def reset
    player.reset
    new_number
  end

  def new_number
    @number = rand(RANGE)
  end
end

game = GuessingGame.new
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
