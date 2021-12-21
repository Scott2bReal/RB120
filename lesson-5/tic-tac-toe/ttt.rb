require 'pry'

module Joinable
  def join_list(list, delim, last_word) # list should be an array
    case list.size
    when 0 then ''
    when 1 then list.first
    when 2 then "#{list.first} #{last_word} #{list.last}"
    else
      "#{list[0..-2].join(delim)}#{delim}#{last_word} #{list[-1]}"
    end
  end
end

module Displayable
  def clear
    system 'clear'
  end

  def blank_line
    puts ""
  end

  def buffer_line
    puts '-----'
  end

  def enter_to_continue
    blank_line
    puts "Please press enter to continue"
    gets
  end

  def display_scoreboard(score1, score2)
    puts <<-MSG
           Score

       *-----+-----*
       |     |     |
  You  |  #{score1}  |  #{score2}  |  Computer
       |     |     |
       *-----+-----*
    
    MSG
  end

  def display_generic_invalid_choice_message
    puts "Sorry, that isn't a valid choice"
  end

  def yes_or_no_question(message)
    answer = nil

    loop do
      puts "#{message} (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n yes no).include?(answer)
      puts "Sorry, must be y or n"
    end

    answer
  end

  def display_human_ultimate_winner_message
    puts "*~ Congratulations, you are the ultimate winner! ~*"
    blank_line
  end

  def display_computer_ultimate_winner_message
    puts ">>> The computer is the ultimate winner! <<<"
    blank_line
  end

  def play_again_prompt
    "Would you like to play again?"
  end

  def display_play_again_message
    puts "Let's play again!"
    blank_line
  end
end

class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
                  [[1, 5, 9], [3, 5, 7]]              # diagonals

  attr_reader :squares

  def []=(key, marker)
    set_square_at(key, marker)
  end

  def [](key)
    @squares[key]
  end

  def initialize
    @squares = {}
    reset
  end

  def draw
    puts <<-MSG

           Board
    
          |     |
       #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}
          |     |
      ----+-----+-----
          |     |
       #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}
          |     |
      ----+-----+-----
          |     |
       #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}
          |     |
    

    MSG
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!winning_marker
  end

  # returns winning marker or nil
  def winning_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if three_identical_markers?(squares)
        return squares.first.marker
      end
    end
    nil
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end

  private

  def three_identical_markers?(squares)
    markers = squares.select(&:marked?).collect(&:marker)
    return false if markers.size != 3
    markers.min == markers.max
  end

  def set_square_at(key, marker)
    @squares[key].marker = marker
  end

  def any_unmarked?(arr)
    # unmarked_keys.include?(@squares[*arr])
    arr.any?(&:unmarked?)
  end

  def winning_line?(line)
    line.each { |marker| return true if line.count(marker) == 3 }
    false
  end
end

class Square
  INITIAL_MARKER = ' '

  attr_accessor :marker

  def initialize
    @marker = INITIAL_MARKER
  end

  def ==(other_square)
    marker == other_square
  end

  def to_s
    @marker.to_s
  end

  def marked?
    marker != INITIAL_MARKER
  end

  def unmarked?
    marker == INITIAL_MARKER
  end
end

class Player
  attr_accessor :marker, :score

  def initialize(marker)
    @marker = marker
    @score = 0
  end

  def scores_a_point
    self.score += 1
  end
end

class TTTGame
  include Displayable, Joinable

  GOAL_SCORE = 2
  MARKERS = ['X', 'O']
  DANGER_SQUARES = {
    1 => [[2, 3], [4, 7], [5, 9]],
    2 => [[1, 3], [5, 8]],
    3 => [[1, 2], [6, 9], [5, 7]],
    4 => [[1, 7], [5, 6]],
    5 => [[1, 9], [3, 7], [4, 6], [2, 8]],
    6 => [[4, 5], [3, 9]],
    7 => [[8, 9], [1, 4], [3, 5]],
    8 => [[7, 9], [2, 5]],
    9 => [[7, 8], [3, 6], [1, 5]]
  }

  def play
    loop do
      clear
      main_game
      display_ultimate_winner_message
      break unless play_again?

      reset_game
    end

    display_goodbye_message
  end

  private

  attr_reader :board, :human, :computer
  attr_accessor :current_player

  def initialize
    @board = Board.new
    @human = Player.new(player_choose_marker)
    @computer = Player.new(computer_choose_marker)
    # @current_player = @human
    @current_player = choose_first_turn
  end

  def main_game
    loop do
      display_board
      player_moves
      display_result
      enter_to_continue
      break if ultimate_winner?

      reset
    end
  end

  def player_moves
    loop do
      current_player == human ? human_moves : computer_moves
      break if board.someone_won? || board.full?

      switch_current_player
      clear_screen_and_display_board if human_turn?
    end

    current_player.scores_a_point if board.someone_won?
  end

  def human_moves
    puts "Choose a square (#{join_list(board.unmarked_keys, ', ', 'or')}): "
    answer = nil

    loop do
      answer = gets.chomp
      break if valid_human_square_choice?(answer)

      display_generic_invalid_choice_message
    end

    board[answer.to_i] = human.marker
  end

  def valid_human_square_choice?(answer)
    return false unless answer.to_f == answer.to_i
    return true if board.unmarked_keys.include?(answer.to_i)
  end

  def computer_moves
    computer_move = try_offense_then_defense

    if computer_move
      board[computer_move] = computer.marker
    elsif board.unmarked_keys.include?(5)
      board[5] = computer.marker
    else
      square = board.unmarked_keys.sample
      board[square] = computer.marker
    end
  end

  def try_offense_then_defense # returns advantageous move or nil
    [computer, human].each do |player|
      at_risk = at_risk_squares(squares_marked_by(player))
      return at_risk.sample unless at_risk.empty?
    end

    nil
  end

  def at_risk_squares(player_squares)
    at_risk = []

    board.unmarked_keys.each do |key|
      player_squares.combination(2) do |combo|
        at_risk << key if DANGER_SQUARES[key].include?(combo)
      end
    end

    at_risk
  end

  def squares_marked_by(player)
    marked_squares = []

    (1..9).each do |key|
      marked_squares << key if board[key] == player.marker
    end
    marked_squares
  end

  # def try_defense # returns a move or nil
  #   at_risk = at_risk_squares(squares_marked_by(human))
  #   board[at_risk.first] = computer.marker unless at_risk.empty?
  # end

  # def try_offense # returns a move or nil
  #   at_risk = at_risk_squares(squares_marked_by(computer))
  #   board[at_risk.first] = computer.marker unless at_risk.empty?
  # end

  def player_choose_marker
    answer = nil
    puts "\nWelcome to Tic Tac Toe! Which marker do you want to use? (X or O)"
    loop do
      answer = gets.chomp
      break if MARKERS.include?(answer.upcase)
      puts "\nI'm sorry, that is not a valid marker. Please select X or O"
    end

    answer.upcase
  end

  def computer_choose_marker
    MARKERS.reject { |marker| marker == human.marker }.first
  end

  def choose_first_turn
    answer = nil

    loop do
      blank_line
      puts "Who would you like to go first? 1) You 2) Computer 3) Random"
      answer = gets.chomp
      break if ['1', '2', '3'].include?(answer)

      display_generic_invalid_choice_message
      puts "Please select using 1, 2 or 3"
    end

    translate_first_turn_choice(answer)
  end

  def translate_first_turn_choice(answer)
    case answer
    when '1' then human
    when '2' then computer
    when '3' then [human, computer].sample
    end
  end

  def ultimate_winner?
    [human, computer].each do |player|
      return true if player.score == GOAL_SCORE
    end
    false
  end

  def display_ultimate_winner_message
    case human.score
    when GOAL_SCORE then display_human_ultimate_winner_message
    else
      display_computer_ultimate_winner_message
    end
  end

  def display_game_info
    display_welcome_message
    display_explanation
    display_scoreboard(human.score, computer.score)
  end

  def display_welcome_message
    puts "Welcome to Tic Tac Toe!"
    blank_line
  end

  def display_explanation
    puts "First to #{GOAL_SCORE} wins is the big winner!"
    blank_line
  end

  def display_goodbye_message
    blank_line
    puts "Thanks for playing Tic Tac Toe! Goodbye!"
  end

  def display_board
    display_game_info
    board.draw
  end

  def clear_screen_and_display_board
    clear
    display_board
  end

  def display_result
    clear_screen_and_display_board
    case board.winning_marker
    when human.marker
      puts 'You won!'
    when computer.marker
      puts 'Computer won!'
    else
      puts "It's a tie!"
    end
  end

  def play_again?
    answer = yes_or_no_question(play_again_prompt)
    answer == 'y'
  end

  def reset
    board.reset
    self.current_player = choose_first_turn
    clear
  end

  def switch_current_player
    self.current_player = current_player == human ? computer : human
  end

  def human_turn?
    current_player == human
  end

  def reset_game
    board.reset
    reset
    [human, computer].each do |player|
      player.score = 0
    end
  end
end

game = TTTGame.new
game.play
