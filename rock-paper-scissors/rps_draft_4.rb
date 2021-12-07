class Move
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

  def >(other_move)
    if rock?
      return true if other_move.scissors?
      false
    elsif paper?
      return true if other_move.rock?
      false
    elsif scissors?
      return true if other_move.paper?
      false
    end
  end

  def <(other_move)
    if rock?
      return true if other_move.paper?
      false
    elsif paper?
      return true if other_move.scissors?
      false
    elsif scissors?
      return true if other_move.rock?
      false
    end
  end

  def to_s
    @value
  end
end

class Player
  attr_accessor :move, :name

  def initialize(player_type=:human)
    @player_type = player_type
    @move = nil
    @name = set_name
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

class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Human.new
    @computer = Computer.new(:computer)
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors!"
  end

  def display_winner # Refactored in this draft
    puts "#{human.name} chose #{human.move}"
    puts "#{computer.name} chose #{computer.move}"

    if human.move > computer.move
      puts "#{human.name} won!"
    elsif human.move < computer.move
      puts "#{computer.name} won!"
    else
      puts "It's a tie!"
    end
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors. Goodbye!"
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

  def play
    display_welcome_message
    loop do
      human.choose
      computer.choose
      display_winner
      break unless play_again?
    end
    display_goodbye_message
  end
end

RPSGame.new.play

# This refactoring does extract some logic into another class, but I think it is
# a needlessly complex impementation. The conditional statement in
# `RPSGame#display_winner` is much easier to read now, which is the main
# improvement. The drawback is that the new `Move` class is very long, with some
# repetition. One of the Launch School OOP exercises introduced the `Comparable`
# module in the Ruby standard library, which would be a good solution to this
# problem.
