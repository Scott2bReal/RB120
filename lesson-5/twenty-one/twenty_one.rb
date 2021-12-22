# module Hand
# end

class Participant
  attr_reader :name
  attr_accessor :hand

  def initialize(name)
    # what would the 'data' or 'states' of a Player object entail?
    # maybe cards? a name?
    @name = name
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
  end
end

class Dealer < Participant
  def show_hand
    # only show one card
  end
end

class Deck
  CARD_VALUES = {
    '2' => 2,
    '3' => 3,
    '4' => 4,
    '5' => 5,
    '6' => 6,
    '7' => 7,
    '8' => 8,
    '9' => 9,
    'J' => 10,
    'Q' => 10,
    'K' => 10,
    'A' => 11
  }

  SUITS = %w(♠ ♥ ♣ ♦)

  attr_reader :cards

  def initialize
    @cards = initialize_deck
    # obviously, we need some data structure to keep track of cards
    # array, hash, something else?
  end

  def deal
    # does the dealer or the deck deal?
    # I'm thinking I want the deck to deal
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

class Hand # card will collaborate
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
    |  #{name}  |
    |     |
    |   #{suit} |
    *-----*
    MSG
  end
end

class Game
  def start
    deal_cards
    show_initial_cards
    player_turn
    dealer_turn
    show_result
  end
end

# Game.new.start
deck = Deck.new
puts deck.cards
