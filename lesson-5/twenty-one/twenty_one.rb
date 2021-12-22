require 'pry'

class Participant
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
    puts hand.cards
  end
end

class Dealer < Participant
  def show_hand
    # only show one card
    puts hand.cards
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

  def deal_card
    # does the dealer or the deck deal?
    # I'm thinking I want the deck to deal
    cards.shuffle!.pop
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

  def to_s
    @cards
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
  INITIAL_DEAL = 2
  NUMBER_OF_PLAYERS = 2

  attr_reader :deck, :player, :dealer

  def initialize
    # Needs a dealer, player, deck, current_player
    @deck = Deck.new
    @player = Player.new
    @dealer = Dealer.new
    @current_player = @player
  end

  def start
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
        participant.hand.cards << deck.deal_card
      end
    end
  end

  def show_initial_cards
    [player, dealer].each(&:show_hand)
    puts "Deck: "
    puts deck.cards
  end
end

Game.new.start
# deck = Deck.new
# puts deck.cards
