class Move
  def to_s
    self.class.to_s.downcase
  end

  def beats?(other_move)
    inferior_moves.include?(other_move.class)
  end
end

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

  attr_reader :move, :name, :score

  def initialize
    @move = nil
    @name = set_name
    @score = 0
  end

  def reset_score
    self.score = 0
  end

  def scores_a_point
    self.score += 1
  end

  def to_s
    name
  end

  private

  attr_writer :move, :name, :score
end

class Human < Player
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

  private

  def set_name
    n = ''
    loop do
      puts welcome_message
      n = gets.chomp.strip
      break unless n.empty?

      puts invalid_name_choice_message
    end

    n
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

  def welcome_message
    "Welcome! Before we begin, what's your name?"
  end

  def invalid_move_choice_message
    "Sorry, invalid choice. Please select using numbers"
  end

  def invalid_name_choice_message
    "Sorry, must enter a value"
  end
end

module Personable
  def only_rock
    Rock
  end

  def lizard_or_spock
    [Lizard, Spock].sample
  end

  def mostly_scissors
    [Scissors, Scissors, Scissors, Rock].sample
  end

  def random
    Player::POSSIBLE_MOVES.sample
  end

  def only_spock
    Spock
  end
end

class Computer < Player
  include Personable

  def choose
    self.move = choose_ai.new
  end

  private

  def choose_ai
    case name
    when 'R2D2'     then only_rock
    when 'Hal'      then lizard_or_spock
    when 'Chappie'  then mostly_scissors
    when 'Sonny'    then random
    when 'Number 5' then only_spock
    end
  end

  def set_name
    possible_names.sample
  end

  def possible_names
    ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5']
  end
end

class Record
  @@number_of_records = 0

  def initialize(players, outcome, match_winner)
    @players = players # Array of the player objects
    @outcome = outcome.nil? ? 'Tie' : outcome
    @match_winner = match_winner
    @@number_of_records += 1
    @round_number = @@number_of_records
  end

  def to_s
    generate_entry
  end

  private

  attr_reader :players, :outcome, :match_winner, :round_number

  def generate_entry
    round_descrip = <<-MSG
Round #{round_number}: #{players[0]} chose #{players[0].move}; #{players[1]} chose #{players[1].move}. Winner: #{outcome}

    MSG

    match_winner.nil? ? round_descrip : (round_descrip + match_winner_message)
  end

  def match_winner_message
    <<-MSG
*~ Match Winner: #{match_winner} ~*

    MSG
  end
end

module Displayable
  def clear_screen
    system('clear')
  end

  def display_game_info
    clear_screen
    display_welcome_message
    puts RPSGame::RULES
    display_score
  end

  def display_welcome_message
    puts "Welcome to #{generate_game_name}!"
    puts "\n"
  end

  def display_score
    scoreboard = <<-MSG
              Score
    ** #{human}: #{human.score}; #{computer}: #{computer.score} **

    MSG

    puts scoreboard
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

  def display_history?
    puts display_history_prompt
    answer = gets.chomp
    return true if answer.downcase == 'y'
    false
  end

  def display_history_prompt
    <<-MSG

Would you like to view the session history? Enter 'y' to view history, or press enter to continue.
    MSG
  end

  def display_history
    clear_screen
    puts "Current Session history:\n\n"
    history.each do |entry|
      puts entry
    end

    continue?
  end

  def display_ultimate_winner
    puts "~~ #{ultimate_winner} wins the match! ~~"
    puts "\n"
  end

  def display_goodbye_message
    puts "Thanks for playing #{generate_game_name}. Goodbye!"
  end
end

class Round
  include Displayable

  def initialize(human, computer)
    @round_winner = 'Tie'
    @human = human
    @computer = computer
  end

  attr_reader :human, :computer, :round_winner

  def play
    human.choose
    computer.choose
    self.round_winner = determine_winner
    update_scores
    display_moves
    display_winner
  end

  private

  attr_writer :round_winner

  def determine_winner
    return human    if human.move.beats?(computer.move)
    return computer if computer.move.beats?(human.move)
    'Tie'
  end

  def update_scores
    case round_winner
    when human    then human.scores_a_point
    when computer then computer.scores_a_point
    end
  end
end

class RPSGame
  include Displayable

  ROUNDS_TO_WIN = 2
  RULES =
    <<-MSG
  Here are the rules:

  Scissors cuts paper. Paper covers rock. Rock crushes lizard. Lizard poisons
  Spock. Spock smashes scissors. Scissors decapitates lizard. Lizard eats paper.
  Paper disproves Spock. Spock vaporizes rock. Rock crushes scissors.

  First to #{ROUNDS_TO_WIN} wins is the ultimate winner!

    MSG

  def initialize
    @human = Human.new
    @computer = Computer.new
    @history = []
  end

  def play
    loop do
      display_game_info
      play_a_round
      update_ultimate_winner if ultimate_winner?
      update_history
      display_history if display_history?
      break if ultimate_winner?
    end
    display_ultimate_winner
    play_again? ? reset_and_play_new_game : display_goodbye_message
  end

  private

  attr_accessor :human, :computer, :round_winner, :ultimate_winner, :history

  def play_a_round
    round = Round.new(human, computer)
    round.play
    self.round_winner = round.round_winner
  end

  def generate_game_name
    Player::POSSIBLE_MOVES.join(', ')
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

  def continue?
    puts "\n"
    puts "Please hit any key to continue!"
    answer = gets.chomp
    return true if answer
  end

  def reset_and_play_new_game
    [human, computer].each(&:reset_score)
    self.ultimate_winner = nil
    play
  end

  def ultimate_winner?
    if human.score == ROUNDS_TO_WIN || computer.score == ROUNDS_TO_WIN
      return true
    end

    false
  end

  def update_ultimate_winner
    self.ultimate_winner = human if human.score == ROUNDS_TO_WIN
    self.ultimate_winner = computer if computer.score == ROUNDS_TO_WIN
  end

  def update_history
    history << Record.new([human, computer], round_winner, ultimate_winner)
  end
end

RPSGame.new.play
