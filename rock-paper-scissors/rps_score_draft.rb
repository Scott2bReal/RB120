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
    (rock? && other_move.scissors?) ||
      (paper? && other_move.rock?) ||
      (scissors? && other_move.paper?)
  end

  def <(other_move)
    (rock? && other_move.paper?) ||
      (paper? && other_move.scissors?) ||
      (scissors? && other_move.rock?)
  end

  def to_s
    @value
  end
end

class Player
  attr_accessor :move, :name, :score

  def initialize(player_type=:human)
    @player_type = player_type
    @move = nil
    @name = set_name
    @score = 0
  end

  def win!
    self.score += 1
  end

  def to_s
    name
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
      puts "Please choose 1) rock, 2) paper, or 3) scissors:"
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
  ROUNDS_TO_WIN = 2

  attr_accessor :human, :computer, :round_winner, :ultimate_winner

  def initialize
    @human = Human.new
    @computer = Computer.new(:computer)
    @round_winner = nil
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors!"
  end

  def display_moves
    puts "\n"
    puts "#{human.name} chose #{human.move}"
    puts "#{computer.name} chose #{computer.move}"
  end

  def display_winner
    if round_winner == human
      puts "#{human} won!"
    elsif round_winner == computer
      puts "#{computer} won!"
    else
      puts "It's a tie!"
    end
  end

  def determine_winner!
    if human.move > computer.move
      human.win!
      self.round_winner = human
    elsif human.move < computer.move
      computer.win!
      self.round_winner = computer
    end
  end

  def display_score
    clear_screen
    puts "The score is #{human}: #{human.score}; #{computer}: #{computer.score}"
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

  def reset_round_winner!
    self.round_winner = nil
  end

  def continue?
    puts "\n"
    puts "Please hit any key to continue!"
    answer = gets.chomp
    return true if answer
  end

  def ultimate_winner?
    return true if human.score == ROUNDS_TO_WIN
    return true if computer.score == ROUNDS_TO_WIN
    false
  end

  def clear_screen
    system('clear')
  end

  def play_new_game!
    [human, computer].each do |player|
      player.score = 0
    end

    play
  end

  def determine_ultimate_winner!
    self.ultimate_winner = human if human.score == ROUNDS_TO_WIN
    self.ultimate_winner = computer if computer.score == ROUNDS_TO_WIN
  end

  def display_ultimate_winner
    puts "#{ultimate_winner} wins the match!"
  end

  def end_of_round
    determine_winner!
    display_moves
    display_winner
    reset_round_winner!
    determine_ultimate_winner!
    continue?
  end

  def play
    display_welcome_message
    loop do
      display_score
      human.choose
      computer.choose
      end_of_round
      break if ultimate_winner?
    end
    display_ultimate_winner
    play_again? ? play_new_game! : display_goodbye_message
  end
end

RPSGame.new.play
