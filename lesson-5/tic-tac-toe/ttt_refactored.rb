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

  def display_scoreboard(score1, score2) # Edit computer.name for general use
    puts <<-MSG
           Score

       *-----+-----*
       |     |     |
  You  |  #{score1}  |  #{score2}  |  #{computer.name}
       |     |     |
       *-----+-----*
    
    MSG
  end

  def display_generic_invalid_choice_message
    puts "Sorry, that isn't a valid choice"
  end

  # Code below is application specific

  def human_grand_champ
    puts "*~ Congratulations #{human.name}, you are the ultimate winner! ~*"
    blank_line
  end

  def comp_grand_champ
    puts ">>> #{computer.name} is the ultimate winner! <<<"
    blank_line
  end

  def display_play_again_message
    puts "Let's play again!"
    blank_line
  end

  def display_game_description
    puts self.class::GAME_DESCRIPTION
  end

  def display_ultimate_winner_message
    human.score == TTTGame::GOAL_SCORE ? human_grand_champ : comp_grand_champ
  end

  def display_game_info
    display_welcome_message
    display_explanation
    display_scoreboard(human.score, computer.score)
  end

  def display_welcome_message
    puts "Hello #{human.name}, welcome to Tic Tac Toe!"
    blank_line
    puts "You will be playing against the computer, #{computer.name}"
    blank_line
  end

  def display_explanation
    puts "First to #{TTTGame::GOAL_SCORE} wins is the big winner!"
    blank_line
  end

  def display_goodbye_message
    blank_line
    puts "Thanks for playing Tic Tac Toe, #{human.name}! Goodbye!"
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

  def display_instructions
    clear
    display_game_description
    blank_line
    board.draw_with_positions
    enter_to_continue
    clear_screen_and_display_board
  end

  def display_human_choice_prompt
    puts "\nChoose a square (#{join_list(board.unmarked_keys, ', ', 'or')}): "
    puts "\nFor game info, type 'info'"
  end

  def display_human_marker_choice_prompt
    puts "\nWelcome to Tic Tac Toe! Which marker do you want to use? (X or O)"
  end

  def display_invalid_marker_choice_message
    puts "\nI'm sorry, that is not a valid marker. Please select X or O"
  end
end

module Verifiable
  def valid_player_name?(answer)
    computer_names = Computer::COMPUTER_NAMES.map(&:downcase)
    return false if computer_names.include?(answer.downcase)
    return false if answer.strip.empty?
    true
  end

  def invalid_name_message
    <<~MSG
    
    I'm sorry, that is not a valid name.
    Please enter a name which is not on the computer team, or empty

    Computer Team:
    #{join_list(Computer::COMPUTER_NAMES, ', ', 'and')}
    
    MSG
  end

  def valid_human_square_choice?(answer)
    unmarked = board.unmarked_keys.map(&:to_s)

    return false unless unmarked.include?(answer)

    true
  end
end

module Promptable
  def yes_or_no_question(message)
    answer = nil

    loop do
      puts "#{message} (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n yes no).include?(answer)
      puts "Sorry, must be yes or no (y/n)"
    end

    answer
  end

  def play_again_prompt
    "Would you like to play again?"
  end

  def enter_to_continue
    blank_line
    puts "Please press enter to continue"
    gets
  end

  def player_choose_name
    answer = nil

    loop do
      puts "Please enter your name:"
      answer = gets.chomp
      break if valid_player_name?(answer)

      puts invalid_name_message
    end

    answer
  end

  def play_again?
    answer = yes_or_no_question(play_again_prompt)
    %w(y yes).include?(answer)
  end

  # Code below is application specific

  def player_choose_marker
    answer = nil

    display_human_marker_choice_prompt
    loop do
      answer = gets.chomp
      break if TTTGame::MARKERS.include?(answer.upcase)

      display_invalid_marker_choice_message
    end

    answer.upcase
  end
end

class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
                  [[1, 5, 9], [3, 5, 7]]              # diagonals

  CENTER_SQUARE = 5

  attr_reader :squares

  def initialize
    @squares = {}
    reset
  end

  def []=(key, marker)
    set_square_at(key, marker)
  end

  def [](key)
    @squares[key]
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

  def draw_with_positions
    puts <<-MSG

           Board
    
          |     |
       1  |  2  |  3
          |     |
      ----+-----+-----
          |     |
       4  |  5  |  6
          |     |
      ----+-----+-----
          |     |
       7  |  8  |  9
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

  def center_square_unmarked?
    self[CENTER_SQUARE].unmarked?
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
  include Joinable

  attr_accessor :marker, :score
  attr_reader :name

  def initialize(marker)
    @marker = marker
    @score = 0
  end

  def scores_a_point
    self.score += 1
  end
end

class Human < Player
  include Verifiable, Promptable

  def initialize(marker)
    super(marker)
    @name = player_choose_name
  end
end

class Computer < Player
  COMPUTER_NAMES = ['Hal', 'Chappie', 'Sonny', 'R2D2', 'C3P0']

  def initialize(marker)
    super(marker)
    @name = COMPUTER_NAMES.sample
  end
end

class TTTGame
  include Displayable, Joinable, Promptable, Verifiable

  GAME_DESCRIPTION = <<~MSG
  ---
  Tic Tac Toe is a 2 player game played on a 3x3 board. Each player takes a turn
  and marks a square on the board. First player to reach 3 squares in a row,
  including diagonals, wins. If all 9 squares are marked and no player has 3
  squares in a row, then the game is a tie.   
  ---

  MSG

  GOAL_SCORE = 2
  MARKERS = ['X', 'O']
  FIRST_TURN_CHOICES = {
    '1' => 'human',
    '2' => 'computer',
    '3' => ['human', 'computer'].sample
  }

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

      reset_match
    end

    display_goodbye_message
  end

  private

  attr_reader :board, :human, :computer
  attr_accessor :current_player

  def initialize
    @board = Board.new
    @human = Human.new(player_choose_marker)
    @computer = Computer.new(computer_choose_marker)
    @current_player = choose_first_turn
  end

  def main_game
    loop do
      display_board
      players_take_turns
      display_result
      enter_to_continue
      break if ultimate_winner?

      reset_game
    end
  end

  def choose_first_turn
    answer = nil

    loop do
      blank_line
      puts "Who would you like to go first? 1) You 2) Computer 3) Random"
      answer = gets.chomp
      break if FIRST_TURN_CHOICES.keys.include?(answer)

      display_generic_invalid_choice_message
      puts "Please select using 1, 2 or 3"
    end

    FIRST_TURN_CHOICES[answer]
  end

  def players_take_turns
    loop do
      current_player == 'human' ? human_moves : computer_moves

      break if board.someone_won? || board.full?

      switch_current_player
      clear_screen_and_display_board if human_turn?
    end

    current_player_scores_a_point if board.someone_won?
  end

  def current_player_scores_a_point
    current_player == 'human' ? human.scores_a_point : computer.scores_a_point
  end

  def human_moves
    answer = human_choice
    board[answer.to_i] = human.marker
  end

  def human_choice
    loop do
      display_human_choice_prompt
      answer = gets.chomp

      if answer.downcase == 'info'
        display_instructions
        next
      end

      return answer if valid_human_square_choice?(answer)

      display_generic_invalid_choice_message
    end
  end

  def computer_moves
    computer_move = try_offense_then_defense

    if computer_move
      board[computer_move] = computer.marker
    elsif board.center_square_unmarked?
      board[Board::CENTER_SQUARE] = computer.marker
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

  def computer_choose_marker
    MARKERS.reject { |marker| marker == human.marker }.first
  end

  def ultimate_winner?
    [human, computer].each do |player|
      return true if player.score == GOAL_SCORE
    end
    false
  end

  def reset_game
    board.reset
    self.current_player = choose_first_turn
    clear
  end

  def switch_current_player
    self.current_player = current_player == 'human' ? 'computer' : 'human'
  end

  def human_turn?
    current_player == 'human'
  end

  def reset_match
    board.reset
    reset_game
    [human, computer].each do |player|
      player.score = 0
    end
  end
end

game = TTTGame.new
game.play
