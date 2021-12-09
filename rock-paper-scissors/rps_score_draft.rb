class Move
  attr_reader :value

  WHO_BEATS_WHO =
    <<-MSG
    Here are the rules:

    Scissors cuts paper. Paper covers rock. Rock crushes lizard. Lizard poisons
    Spock. Spock smashes scissors. Scissors decapitates lizard. Lizard eats paper.
    Paper disproves Spock. Spock vaporizes rock. Rock crushes scissors.

    MSG

  VALUES = {
    'rock' => %w(lizard scissors),
    'paper' => %w(rock spock),
    'scissors' => %w(paper lizard),
    'lizard' => %w(spock paper),
    'spock' => %w(rock scissors)
  }

  def initialize(value)
    @value = value
  end

  def >(other_move)
    VALUES[value].include?(other_move.value)
  end

  def <(other_move)
    VALUES[other_move.value].include?(value)
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
    answer = nil
    loop do
      puts "Please choose 1) rock, 2) paper, 3) scissors, 4) lizard, 5) spock:"
      answer = gets.chomp
      break if ['1', '2', '3', '4', '5'].include?(answer)

      puts "Sorry, invalid choice. Please select using 1, 2, 3, 4 or 5"
    end

    choice = translate_choice(answer)
    self.move = Move.new(choice)
  end

  def translate_choice(answer)
    case answer
    when '1' then 'rock'
    when '2' then 'paper'
    when '3' then 'scissors'
    when '4' then 'lizard'
    when '5' then 'spock'
    end
  end
end

class Computer < Player
  def set_name
    ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].sample
  end

  def choose
    mv = Move::VALUES.keys.sample
    self.move = Move.new(mv)
  end
end

class RPSGame
  ROUNDS_TO_WIN = 10

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
    puts Move::WHO_BEATS_WHO
    scoreboard = <<-MSG
              Score
    ** #{human}: #{human.score}; #{computer}: #{computer.score} **"

    MSG

    puts scoreboard
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

  def clear_screen
    system('clear')
  end

  def play_new_game!
    [human, computer].each do |player|
      player.score = 0
    end

    self.ultimate_winner = nil
    play
  end

  def ultimate_winner?
    if human.score == ROUNDS_TO_WIN || computer.score == ROUNDS_TO_WIN
      return true
    end
    false
  end

  def ultimate_winner!
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
    ultimate_winner! if ultimate_winner?
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
