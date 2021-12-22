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

class Participant
  include Joinable, Displayable

  attr_reader :name
  attr_accessor :hand

  def initialize
    # what would the 'data' or 'states' of a Player object entail?
    # maybe cards? a name?
    # @name = name
    @hand = Hand.new
  end

  def hit
    # deck will give one card to hand
  end

  def stay
    # what happens here?
  end
end

class Player < Participant
  def show_hand
    # show all cards in hand
    # probably total as well
    puts "Player hand:"
    puts hand
  end
end

class Dealer < Participant
  attr_reader :deck

  def initialize(deck)
    super()
    @deck = deck
  end

  def show_hand
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

  def busted?
    total > MAX_POINTS
  end

  def update_total
    cards.each do |card|
      self.total += card.value
    end

    calculate_aces if total > MAX_POINTS
  end

  def to_s
    hand_string = ''

    cards.each do |card|
      hand_string << card.to_s
    end

    hand_string
  end

  private

  def calculate_aces
    aces = number_of_aces

    until aces == 0
      aces -= 1
      self.total -= 10
    end
  end

  def number_of_aces
    cards.select { |card| card.name == 'A' }.size
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
  include Displayable

  INITIAL_DEAL = 2
  NUMBER_OF_PLAYERS = 2

  attr_reader :deck, :player, :dealer

  def initialize
    @deck = Deck.new
    @player = Player.new
    @dealer = Dealer.new(deck)
    @current_player = @player
  end

  def start
    clear
    initial_deal
    show_initial_cards
    # player_turn
    # dealer_turn
    # show_result
  end

  private

  def initial_deal
    [player, dealer].each do |participant|
      INITIAL_DEAL.times do
        participant.hand.cards << dealer.deal_card
      end
    end
  end

  def show_initial_cards
    [dealer, player].each(&:show_hand)
  end
end

Game.new.start
# deck = Deck.new
# puts deck.cards
