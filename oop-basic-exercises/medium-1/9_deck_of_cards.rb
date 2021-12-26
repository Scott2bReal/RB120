# Using the Card class from the previous exercise, create a Deck class that
# contains all of the standard 52 playing cards. Use the following code to start
# your work:
class Deck
  RANKS = ((2..10).to_a + %w(Jack Queen King Ace)).freeze
  SUITS = %w(Hearts Clubs Diamonds Spades).freeze

  attr_accessor :cards

  def initialize
    @cards = []
    reset
  end

  def draw
    reset if cards.empty?
    cards.pop
  end

  private

  def reset
    RANKS.each do |rank|
      SUITS.each do |suit|
        cards << Card.new(rank, suit)
      end
    end

    cards.shuffle!
  end
end

class Card
  include Comparable

  attr_reader :suit, :face
  attr_accessor :rank

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def translate_rank
    case rank
    when 'Jack'  then 11
    when 'Queen' then 12
    when 'King'  then 13
    when 'Ace'   then 14
    else
      rank
    end
  end

  def ==(other_card)
    translate_rank == other_card.translate_rank
  end

  def <=>(other_card)
    translate_rank <=> other_card.translate_rank
  end

  def to_s
    "#{rank} of #{suit}"
  end
end

# Deck class should provide a #draw method to deal one card. The Deck should be
# shuffled when it is initialized and, if it runs out of cards, it should reset
# itself by generating a new set of 52 shuffled cards.

# Examples:

deck = Deck.new
drawn = []
52.times { drawn << deck.draw }
puts drawn.count { |card| card.rank == 5 } == 4
puts drawn.count { |card| card.suit == 'Hearts' } == 13

drawn2 = []
52.times { drawn2 << deck.draw }
puts drawn != drawn2 # Almost always.
