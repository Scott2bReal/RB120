class Move
  attr_reader :value

  def to_s
    self.class.to_s.downcase
  end

  def beats?(other_move)
    inferior_moves.include?(other_move.class)
  end
end

# To add a new move type, simply make a class for it, edit the inferior_moves
# for all classes accordingly, include the class name in Player#possible_moves,
# and edit RPSGame#RULES to reflect the new rules.

class Rock < Move
  def inferior_moves
    [Scissors, Lizard]
  end
end

class Paper < Move
  def inferior_moves
    [Rock, Spock]
  end
end

class Scissors < Move
  def inferior_moves
    [Paper, Lizard]
  end
end

class Lizard < Move
  def inferior_moves
    [Spock, Paper]
  end
end

class Spock < Move
  def inferior_moves
    [Rock, Scissors]
  end
end

class Player
  POSSIBLE_MOVES = [Rock, Paper, Scissors, Lizard, Spock]

  attr_accessor :move, :name, :score

  def initialize
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

      puts invalid_name_choice_message
    end

    n
  end

  def choose
    answer = nil
    loop do
      puts move_choice_prompt
      answer = gets.chomp
      break if valid_answer?(answer)

      puts invalid_move_choice_message
    end

    self.move = translate_choice(answer)
  end

  def move_choice_prompt
    choices = []

    Player::POSSIBLE_MOVES.each_with_index do |choice, idx|
      choices << "#{idx + 1}) #{choice}"
    end

    "#{name}, please select your move: #{choices.join(', ')}"
  end

  def valid_answer?(answer)
    (1..Player::POSSIBLE_MOVES.size).include?(answer.to_i)
  end

  def translate_choice(answer)
    Player::POSSIBLE_MOVES[answer.to_i - 1].new
  end

  def invalid_move_choice_message
    "Sorry, invalid choice. Please select using numbers"
  end

  def invalid_name_choice_message
    "Sorry, must enter a value"
  end
end

class Computer < Player
  def set_name
    possible_names.sample
  end

  def possible_names
    ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5']
  end

  def choose
    mv = Player::POSSIBLE_MOVES.sample
    self.move = mv.new
  end
end

class RPSGame
  ROUNDS_TO_WIN = 2
  RULES =
    <<-MSG
  Here are the rules:

  Scissors cuts paper. Paper covers rock. Rock crushes lizard. Lizard poisons
  Spock. Spock smashes scissors. Scissors decapitates lizard. Lizard eats paper.
  Paper disproves Spock. Spock vaporizes rock. Rock crushes scissors.

  First to #{ROUNDS_TO_WIN} wins is the ultimate winner!

    MSG

  attr_accessor :human, :computer, :round_winner, :ultimate_winner

  def initialize
    @human = Human.new
    @computer = Computer.new
    @round_winner = nil
  end

  def display_welcome_message
    puts "Welcome to #{generate_game_name}!"
    puts "\n"
  end

  def generate_game_name
    Player::POSSIBLE_MOVES.join(', ')
  end

  def display_moves
    puts "\n"
    puts "#{human} chose #{human.move}"
    puts "#{computer} chose #{computer.move}"
  end

  def display_winner
    if round_winner == human
      puts "\n** #{human} won the round! **"
    elsif round_winner == computer
      puts "\n** #{computer} won the round! **"
    else
      puts "\n** It's a tie! **"
    end
  end

  def determine_winner!
    if human.move.beats?(computer.move)
      human.win!
      self.round_winner = human
    elsif computer.move.beats?(human.move)
      computer.win!
      self.round_winner = computer
    end
  end

  def display_score
    scoreboard = <<-MSG
              Score
    ** #{human}: #{human.score}; #{computer}: #{computer.score} **

    MSG

    puts scoreboard
  end

  def display_game_info
    clear_screen
    display_welcome_message
    puts RPSGame::RULES
    display_score
  end

  def display_goodbye_message
    puts "Thanks for playing #{generate_game_name}. Goodbye!"
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
    puts "~~ #{ultimate_winner} wins the match! ~~"
    puts "\n"
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
    loop do
      display_game_info
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
