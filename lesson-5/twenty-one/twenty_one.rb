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
  end

  def stay
  end
end

class Player < Participant
end

class Dealer < Participant
  def deal
    # does the dealer o the deck deal?
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
    'A' => 11,
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
  end

  private

  def initialize_deck
    # For each possible name of card create a new Card
    # for each of these, iterate thru the suits and make a card with the name
    # value and suit of the current iterations
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
  def initialize
    @cards = []
  end

  def busted?
  end

  def total
    # definitely looks like we need to know about 'cards' to produce some total
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
