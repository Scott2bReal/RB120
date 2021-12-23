require 'pry'

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

  def display_goodbye_message
    "Thanks for playing, goodbye!"
  end
end

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

  def hit_or_stay_prompt
    answer = nil

    loop do
      puts "Would you like to 1) hit or 2) stay?"
      answer = gets.chomp
      break if ['1', '2'].include?(answer)

      puts "Please select using numbers 1 or 2"
    end

    answer
  end
end

module Hand
  MAX_POINTS = 21

  def busted?
    total > MAX_POINTS
  end

  def update_total(card)
    self.total += card.value
    calculate_ace_values if busted?
  end

  def to_s
    hand_string = ''

    cards.each do |card|
      hand_string << card.to_s
    end

    hand_string
  end

  def calculate_ace_values
    aces = number_of_aces

    until aces == 0
      aces -= 1
      self.total -= 10 if busted?
    end
  end

  def number_of_aces
    cards.select { |card| card.name == ' A' }.size
  end

  def hit
    card = deck.cards.shuffle!.pop
    cards << card
    update_total(card)
  end

  def stay
    total
  end
end

class Player
  include Joinable, Displayable, Hand

  attr_reader :deck
  attr_accessor :total, :cards

  def initialize(deck)
    @cards = []
    @total = 0
    @deck = deck
  end

  def <=>(other_participant)
    hand.total <=> other_participant.hand.total
  end

  def show_hand
    puts "#{self.class} hand (total score = #{total})"
    puts cards
  end
end

class Dealer < Player
  def show_initial_hand
    # only show one card

    puts <<~MSG
    Dealer hand:
    #{cards.first} ???  
    MSG
    # puts "Dealer hand:"
    # puts hand.cards.first
    # puts "???"
    # blank_line
    # buffer_line
  end

  def deal_card
    deck.cards.shuffle!.pop
  end
end

class Deck
  CARD_VALUES = {
    ' 2' => 2,
    ' 3' => 3,
    ' 4' => 4,
    ' 5' => 5,
    ' 6' => 6,
    ' 7' => 7,
    ' 8' => 8,
    ' 9' => 9,
    '10' => 10,
    ' J' => 10,
    ' Q' => 10,
    ' K' => 10,
    ' A' => 11
  }

  SUITS = %w(♠ ♥ ♣ ♦)

  attr_accessor :cards

  def initialize
    @cards = reset
  end

  def reset
    cards = []

    CARD_VALUES.each do |name, value|
      SUITS.each do |suit|
        cards << Card.new(name, value, suit)
      end
    end

    cards
  end
end

class Card
  def initialize(name, value, suit)
    @name = name
    @suit = suit
    @value = value
  end

  attr_reader :suit, :name, :value

  def to_s
    <<~MSG
    *-----*
    |#{suit}    |
    |     |
    | #{name}  |
    |     |
    |   #{suit} |
    *-----*
    MSG
  end
end

class Game
  include Displayable, Promptable, Hand

  INITIAL_DEAL = 2
  NUMBER_OF_PLAYERS = 2

  def initialize
    @deck = Deck.new
    @player = Player.new(deck)
    @dealer = Dealer.new(deck)
    @current_player = @player
    @winner = nil
  end

  def start
    loop do
      initial_deal
      clear_screen_and_display_game_info
      player_turn
      dealer_turn
      show_result
      break unless play_again?
      reset
    end
    display_goodbye_message
  end

  private

  attr_accessor :current_player, :winner
  attr_reader :deck, :player, :dealer

  def initial_deal
    [player, dealer].each do |participant|
      INITIAL_DEAL.times do
        participant.hit
      end
    end
  end

  def players_take_turns
    player_turn
    dealer_turn
  end

  def player_turn
    loop do
      break if player.busted?

      hit_or_stay_prompt == '1' ? player.hit : break
      clear_screen_and_display_game_info
    end

    @winner = dealer if player.busted?
  end

  def dealer_turn
    until dealer.total >= 17
      dealer.hit
    end

    self.winner = player if dealer.busted?
  end

  def clear_screen_and_display_game_info
    clear
    # [dealer, player].each(&:show_hand)
    dealer.show_initial_hand
    player.show_hand
  end

  def show_result
    clear
    [dealer, player].each(&:show_hand)
    display_winner_message
  end

  def display_winner_message
    if winner
      puts "The winner is: #{determine_winner.class}"
    else
      puts "It's a tie!"
    end
  end

  def determine_winner
    winner == player ? player : dealer
  end

  def reset
    deck.reset
    reset_hands
  end

  def reset_hands
    [dealer, player].each do |participant|
      participant.cards = []
      participant.total = 0
    end
  end
end

Game.new.start
