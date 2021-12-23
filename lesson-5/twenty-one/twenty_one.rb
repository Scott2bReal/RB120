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
      puts "Would you like to hit or stay?"
      answer = gets.chomp
      break if ['hit', 'stay'].include?(answer)
    end

    answer
  end
end

module Hand
  MAX_POINTS = 21

  def busted?
    total > MAX_POINTS
  end

  def update_total
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
    card = deck.shuffle!.pop
    cards << card
    update_total(card)
  end

  def stay
    # what happens here?
  end
end

class Participant
  include Joinable, Displayable, Hand

  attr_reader :name, :total

  def initialize
    @hand = Hand.new
    @cards = []
    @total = 0
  end

  def <=>(other_participant)
    hand.total <=> other_participant.hand.total
  end

  def show_hand
    hand.update_total
    puts "#{self.class} hand (total score = #{hand.total})"
    puts hand
  end
end

class Player < Participant
end

class Dealer < Participant
  attr_reader :deck

  def initialize(deck)
    super()
    @deck = deck
  end

  def show_initial_hand
    # only show one card
    puts "Dealer hand:"
    puts hand.cards.first
    puts "???"
    blank_line
    buffer_line
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
    @cards = initialize_deck
  end

  private

  def initialize_deck
    cards = []

    CARD_VALUES.each do |name, value|
      SUITS.each do |suit|
        cards << Card.new(name, value, suit)
      end
    end

    cards
  end
end

class Hand
  MAX_POINTS = 21

  attr_accessor :cards, :total

  def initialize
    @cards = []
    @total = 0
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
  include Displayable, Promptable

  INITIAL_DEAL = 2
  NUMBER_OF_PLAYERS = 2

  attr_reader :deck, :player, :dealer
  attr_accessor :current_player, :winner

  def initialize
    @deck = Deck.new
    @player = Player.new
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

  def initial_deal
    [player, dealer].each do |participant|
      INITIAL_DEAL.times do
        participant.hand.cards << dealer.deal_card
      end
    end
  end

  def clear_screen_and_display_game_info
    clear
    # [dealer, player].each(&:show_hand)
    dealer.show_initial_hand
    player.show_hand
  end

  def player_turn
    loop do
      answer = hit_or_stay_prompt
      break if answer == 'stay'

      current_player.hand.cards << dealer.deal_card
      self.winner = dealer if player.hand.busted?
      clear_screen_and_display_game_info
    end
    self.current_player = dealer
  end

  def dealer_turn
    loop do
      current_player.hand.cards << dealer.deal_card
      dealer.hand.update_total
      break if dealer.hand.total >= 17
    end

    self.winner = player if dealer.hand.busted?
  end

  def show_result
    clear
    dealer.show_hand
    player.show_hand
    display_winner
  end

  def display_winner
    if winner
      puts "The winner is: #{winner.class}"
    else
      puts "It's a tie!"
    end
  end

  def determine_winner
    return winner if winner

    case player <=> dealer
    when 1 then player
    when 0 then nil
    when -1 then dealer
    end
  end

  def reset
    self.initialize
  end
end

Game.new.start
