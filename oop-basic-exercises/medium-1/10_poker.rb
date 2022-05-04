# In the previous two exercises, you developed a Card class and a Deck class.
# You are now going to use those classes to create and evaluate poker hands.
# Create a class, PokerHand, that takes 5 cards from a Deck of Cards and
# evaluates those cards as a Poker hand. If you've never played poker before,
# you may find this overview of poker hands useful.

# You should build your class using the following code skeleton:
require 'pry'

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

  VALUES = { 'Jack' => 11, 'Queen' => 12, 'King' => 13, 'Ace' => 14 }

  attr_reader :suit
  attr_accessor :rank

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def value
    VALUES.fetch(rank, rank)
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

  def <=>(other_card)
    value <=> other_card.value
  end

  def to_s
    "#{rank} of #{suit}"
  end
end

# Include Card and Deck classes from the last two exercises.

class PokerHand
  ROYAL_RANKS = [10, 'Jack', 'Queen', 'King', 'Ace']

  def initialize(deck)
    @deck = deck
    @cards = []
    5.times { cards << deck.draw }
  end

  def print
    puts cards
  end

  def evaluate
    case
    when royal_flush?     then 'Royal flush'
    when straight_flush?  then 'Straight flush'
    when four_of_a_kind?  then 'Four of a kind'
    when full_house?      then 'Full house'
    when flush?           then 'Flush'
    when straight?        then 'Straight'
    when three_of_a_kind? then 'Three of a kind'
    when two_pair?        then 'Two pair'
    when pair?            then 'Pair'
    else                       'High card'
    end
  end

  private

  attr_reader :deck, :cards

  def ranks
    cards.map(&:rank)
  end

  def suits
    cards.map(&:suit)
  end

  def royal?
    ranks.select { |suit| ROYAL_RANKS.include?(suit) }.size == 5
  end

  def royal_flush?
    flush? && royal?
  end

  def straight_flush?
    flush? && straight?
  end

  def four_of_a_kind?
    cards.any? { |card| cards.count(card) == 4 }
  end

  def full_house?
    ranks.uniq.count == 2
  end

  def flush?
    suits.uniq.count == 1
  end

  def straight?
    values = cards.map(&:value)
    (values.min..values.max).size == 5 && ranks.uniq.size == 5
  end

  def three_of_a_kind?
    ranks.any? { |rank| ranks.count(rank) == 3 }
  end

  def two_pair?
    ranks.uniq.count == 3
  end

  def pair?
    ranks.any? { |rank| ranks.count(rank) == 2 }
  end
end

# Testing your class:

# hand = PokerHand.new(Deck.new)
# hand.print
# puts hand.evaluate

# Danger danger danger: monkey
# patching for testing purposes.
class Array
  alias_method :draw, :pop
end

# Test that we can identify each PokerHand type.
# hand = PokerHand.new([
#   Card.new(10,      'Hearts'),
#   Card.new('Ace',   'Hearts'),
#   Card.new('Queen', 'Hearts'),
#   Card.new('King',  'Hearts'),
#   Card.new('Jack',  'Hearts')
# ])
# puts "Royal Flush: #{hand.evaluate == 'Royal flush'}"

# hand = PokerHand.new([
#   Card.new(8,       'Clubs'),
#   Card.new(9,       'Clubs'),
#   Card.new('Queen', 'Clubs'),
#   Card.new(10,      'Clubs'),
#   Card.new('Jack',  'Clubs')
# ])
# puts "Straight Flush: #{hand.evaluate == 'Straight flush'}"

# hand = PokerHand.new([
#   Card.new(3, 'Hearts'),
#   Card.new(3, 'Clubs'),
#   Card.new(5, 'Diamonds'),
#   Card.new(3, 'Spades'),
#   Card.new(3, 'Diamonds')
# ])
# puts "4 of a kind: #{hand.evaluate == 'Four of a kind'}"

# hand = PokerHand.new([
#   Card.new(3, 'Hearts'),
#   Card.new(3, 'Clubs'),
#   Card.new(5, 'Diamonds'),
#   Card.new(3, 'Spades'),
#   Card.new(5, 'Hearts')
# ])
# puts "Full House: #{hand.evaluate == 'Full house'}"

# hand = PokerHand.new([
#   Card.new(10, 'Hearts'),
#   Card.new('Ace', 'Hearts'),
#   Card.new(2, 'Hearts'),
#   Card.new('King', 'Hearts'),
#   Card.new(3, 'Hearts')
# ])
# puts "Flush: #{hand.evaluate == 'Flush'}"

# hand = PokerHand.new([
#   Card.new(8,      'Clubs'),
#   Card.new(9,      'Diamonds'),
#   Card.new(10,     'Clubs'),
#   Card.new(7,      'Hearts'),
#   Card.new('Jack', 'Clubs')
# ])
# puts "Straight: #{hand.evaluate == 'Straight'}"

# hand = PokerHand.new([
#   Card.new('Queen', 'Clubs'),
#   Card.new('King',  'Diamonds'),
#   Card.new(10,      'Clubs'),
#   Card.new('Ace',   'Hearts'),
#   Card.new('Jack',  'Clubs')
# ])
# puts "Straight: #{hand.evaluate == 'Straight'}"

# hand = PokerHand.new([
#   Card.new(3, 'Hearts'),
#   Card.new(3, 'Clubs'),
#   Card.new(5, 'Diamonds'),
#   Card.new(3, 'Spades'),
#   Card.new(6, 'Diamonds')
# ])
# puts "3 of a kind: #{hand.evaluate == 'Three of a kind'}"

# hand = PokerHand.new([
#   Card.new(9, 'Hearts'),
#   Card.new(9, 'Clubs'),
#   Card.new(5, 'Diamonds'),
#   Card.new(8, 'Spades'),
#   Card.new(5, 'Hearts')
# ])
# puts "Two Pair: #{hand.evaluate == 'Two pair'}"

# hand = PokerHand.new([
#   Card.new(2, 'Hearts'),
#   Card.new(9, 'Clubs'),
#   Card.new(5, 'Diamonds'),
#   Card.new(9, 'Spades'),
#   Card.new(3, 'Diamonds')
# ])
# puts "Pair: #{hand.evaluate == 'Pair'}"

# hand = PokerHand.new([
#   Card.new(2,      'Hearts'),
#   Card.new('King', 'Clubs'),
#   Card.new(5,      'Diamonds'),
#   Card.new(9,      'Spades'),
#   Card.new(3,      'Diamonds')
# ])
# puts "High Card: #{hand.evaluate == 'High card'}"

# 5 of Clubs
# 7 of Diamonds
# Ace of Hearts
# 7 of Clubs
# 5 of Spades
# Two pair
# true
# true
# true
# true
# true
# true
# true
# true
# true
# true
# true
# true
# true

# The exact cards and the type of hand will vary with each run.

# Most variants of Poker allow both Ace-high (A, K, Q, J, 10) and Ace-low (A, 2,
# 3, 4, 5) straights. For simplicity, your code only needs to recognize Ace-high
# straights.

# If you are unfamiliar with Poker, please see this description of the various
# hand types. Since we won't actually be playing a game of Poker, it isn't
# necessary to know how to play.

deck = Deck.new
hand = PokerHand.new(deck)
counter = 0

until hand.evaluate == "Royal flush"
  p counter += 1
  hand = PokerHand.new(deck)
end

puts "It took #{counter} times to make a royal flush!"
