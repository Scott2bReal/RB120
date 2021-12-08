class Move
  include Comparable # Decided to use Comparable after encountering it in an exercise

  attr_reader :value

  VALUES = ['rock', 'paper', 'scissors']

  def initialize(value)
    @value = value
  end

  def rock?
    @value == 'rock'
  end

  def paper?
    @value == 'paper'
  end

  def scissors?
    @value == 'scissors'
  end

  def <=>(other_move) # Refactor of < and > methods for simplicity
    move <=> other_move
  end

  def to_s
    @value
  end
end

# In this draft will try giving the Player class a score attribute

class Player
  attr_accessor :move, :name, :score, :winner

  def initialize
    @move = nil
    @name = set_name
    @score = 0
    @winner = false
  end

  def winner?
    self.winner
  end

  def wins!
    self.winner = true
    self.score += 1
  end

  def to_s
    self.name
  end
end


class Human < Player
  def set_name
    n = ''
    loop do
      puts "What's your name?"
      n = gets.chomp
      break unless n.empty?
      puts "Sorry, must enter a value"
    end

    n
  end

  def choose
    choice = nil
    loop do
      puts "Please choose rock, paper, or scissors:"
      choice = gets.chomp
      break if Move::VALUES.include?(choice)

      puts "Sorry, invalid choice"
    end

    self.move = Move.new(choice)
  end
end

class Computer < Player
  def set_name
    ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].sample
  end

  def choose
    mv = Move::VALUES.sample
    self.move = Move.new(mv)
  end
end

# Give Player a @winner
# Change display_winner to determine winner
# Make replacement display_winner method

class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Human.new
    @computer = Computer.new  
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors!"
  end

  def display_moves # Extracted this method from display_winner
    puts "\n"
    puts "#{human.name} chose #{human.move}"
    puts "#{computer.name} chose #{computer.move}"
  end

  def determine_winner!
    human.move > computer.move ? human.wins! : computer.wins!
  end

  def display_winner
    puts "\n"
    if human.winner?
      puts "#{human} wins!"
    elsif computer.winner?
      puts "#{computer} wins!"
    else
      puts "It's a tie!"
    end
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors. Goodbye!"
  end

  def display_score
    puts "The score is Human: #{human.score}, Computer: #{computer.score}"
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp
      break if ['y', 'n'].include?(answer)
      puts "Sorry must be y or n."
    end

    return true if answer == 'y'
    false
  end

  def ultimate_winner?
    return true if human.score == 3 || computer.score == 3
  end

  def reset_scores!
    human.score = 0
    computer.score = 0
  end

  def best_of_three 
    loop do
      human.choose
      computer.choose
      display_moves
      display_winner
      display_score
      break if ultimate_winner?
    end
  end

  def play
    display_welcome_message
    loop do
      self.best_of_three
      break unless play_again?
    end

    display_goodbye_message
  end
end

RPSGame.new.play
