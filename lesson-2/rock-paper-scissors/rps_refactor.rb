class Move
  def to_s
    self.class.to_s.downcase
  end

  def beats?(other_move)
    self.class::INFERIOR_MOVES.include?(other_move.class.to_s)
  end
end

class Rock < Move
  INFERIOR_MOVES = ['Scissors', 'Lizard']
end

class Paper < Move
  INFERIOR_MOVES = ['Rock', 'Spock']
end

class Scissors < Move
  INFERIOR_MOVES = ['Paper', 'Lizard']
end

class Lizard < Move
  INFERIOR_MOVES = ['Spock', 'Paper']
end

class Spock < Move
  INFERIOR_MOVES = ['Rock', 'Scissors']
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

module Joinable
  def join_list(list, last_word) # list should be an array size > 1
    if list.size > 2
      "#{list[0..-2].join(', ')}, #{last_word} #{list[-1]}"
    elsif list.size == 2
      "#{list[0]} #{last_word} #{list[1]}"
    end
  end
end

class Human < Player
  include Joinable

  def choose
    answer = nil
    loop do
      puts move_choice_prompt
      answer = gets.chomp
      break if valid_choice?(answer)

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
      break if valid_name?(n)

      puts invalid_name_choice_message(n)
    end

    n
  end

  def valid_name?(n)
    return false if n.empty? || Computer.possible_names.include?(n)
    true
  end

  def move_choice_prompt
    choices = []

    Player::POSSIBLE_MOVES.each_with_index do |choice, idx|
      choices << "#{idx + 1}) #{choice}"
    end

    "#{name}, please select your move: #{join_list(choices, 'or')}"
  end

  def valid_choice?(answer)
    (1..Player::POSSIBLE_MOVES.size).to_a.include?(answer.to_f)
  end

  def translate_choice(answer)
    Player::POSSIBLE_MOVES[answer.to_i - 1].new
  end

  def welcome_message
    "Welcome! Before we begin, what's your name?"
  end

  def invalid_move_choice_message
    <<~MSG

    Sorry, invalid choice. Please select using #{join_list((1..Player::POSSIBLE_MOVES.size).to_a, 'or')}

    MSG
  end

  def invalid_name_choice_message(n)
    if n.empty?
      "Sorry, please enter a name"
    elsif Computer.possible_names.include?(n)
      <<~MSG

        Please enter a name which is not a computer's name. The computer team is #{join_list(Computer.possible_names, 'and')}

      MSG
    end
  end
end

class Computer < Player
  @@possible_names = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5']

  def self.possible_names
    @@possible_names
  end

  def self.choose_ai
    [OnlyRock, LizardOrSpock, MostlyScissors, AnyMove, OnlySpock].sample
  end

  def set_name
    @@possible_names.sample
  end
end

class OnlyRock < Computer
  def choose
    self.move = Rock.new
  end
end

class LizardOrSpock < Computer
  def choose
    self.move = [Lizard, Spock].sample.new
  end
end

class MostlyScissors < Computer
  def choose
    self.move = [Scissors, Scissors, Scissors, Rock].sample.new
  end
end

class AnyMove < Computer
  def choose
    self.move = Player::POSSIBLE_MOVES.sample.new
  end
end

class OnlySpock < Computer
  def choose
    self.move = Spock.new
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
    round_descrip = <<~MSG
      Round #{round_number}: #{players[0]} chose #{players[0].move}; #{players[1]} chose #{players[1].move}. Winner: #{outcome}

    MSG

    match_winner.nil? ? round_descrip : (round_descrip + match_winner_message)
  end

  def match_winner_message
    <<~MSG
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
    puts history_prompt
    answer = gets.chomp
    return true if answer.downcase == 'h'
    false
  end

  def history_prompt
    <<~MSG

      Would you like to view the session history? Enter 'h' to view history, or press enter to continue.
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

  GOAL_SCORE = 10
  RULES =
    <<-MSG
  Here are the rules:

  Scissors cuts paper. Paper covers rock. Rock crushes lizard. Lizard poisons
  Spock. Spock smashes scissors. Scissors decapitates lizard. Lizard eats paper.
  Paper disproves Spock. Spock vaporizes rock. Rock crushes scissors.

  First to #{GOAL_SCORE} wins is the ultimate winner!

    MSG

  def initialize
    @human = Human.new
    @computer = Computer.choose_ai.new
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
      break if ['y', 'n', 'yes', 'no'].include?(answer)
      puts "Sorry must be yes or no (y/n)."
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
    return true if human.score == GOAL_SCORE || computer.score == GOAL_SCORE

    false
  end

  def update_ultimate_winner
    self.ultimate_winner = human    if human.score == GOAL_SCORE
    self.ultimate_winner = computer if computer.score == GOAL_SCORE
  end

  def update_history
    history << Record.new([human, computer], round_winner, ultimate_winner)
  end
end

RPSGame.new.play
