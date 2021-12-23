require 'pry'

module Displayable
  def prompt(message)
    puts "=> #{message}"
  end

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
    prompt "Sorry, that isn't a valid choice"
  end

  def display_goodbye_message
    "Thanks for playing, goodbye!"
  end

  def yes_or_no_question(message)
    answer = nil

    loop do
      prompt "#{message} (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n yes no).include?(answer)
      prompt "Sorry, must be yes or no (y/n)"
    end

    answer
  end

  def play_again_prompt
    "Would you like to play again?"
  end

  def play_again?
    answer = yes_or_no_question(play_again_prompt)
    %w(y yes).include?(answer)
  end

  def enter_to_continue
    blank_line
    prompt "Please press enter to continue"
    gets
  end

  def hit_or_stay_prompt
    answer = nil

    loop do
      prompt "Would you like to 1) hit or 2) stay?"
      answer = gets.chomp
      break if ['1', '2'].include?(answer)

      prompt "Please select using numbers 1 or 2"
    end

    answer
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
    @total = 0

    cards.each do |card|
      @total += card.value
      if busted?
        @total -= 10 if card.ace?
      end
    end
    # aces = number_of_aces

    # until aces == 0
    #   aces -= 1
    #   self.total -= 10 if busted?
    # end
  end

  def number_of_aces
    cards.select(&:ace?).size
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
  include Joinable, Displayable, Hand, Comparable

  attr_reader :deck, :name
  attr_accessor :total, :cards

  def initialize(deck)
    @cards = []
    @total = 0
    @deck = deck
    # @name = player_choose_name
  end

  def <=>(other_participant)
    total <=> other_participant.total
  end

  def show_hand
    prompt <<~MSG
    #{self.class} has: #{join_list(cards, ', ', 'and')} (total score = #{total})

    MSG
  end

  def to_s
    self.class
  end

  def player_choose_name
    answer = nil

    loop do
      prompt "Please enter your name:"
      answer = gets.chomp
      break if valid_player_name?(answer) # define in class

      prompt invalid_name_message           # define in class
    end

    answer
  end

  def invalid_name_message
    <<~MSG
    Please select a name which is not a dealer name or empty.
    Computer team: 
    #{Dealer::DEALER_NAMES}
    
    MSG
  end

  def valid_player_name?(answer)
    return false if Dealer::DEALER_NAMES.include?(answer) || answer.strip.empty?
    true
  end
end

class Dealer < Player
  DEALER_NAMES = %w(R2D2 C3P0)

  def show_initial_hand
    prompt <<~MSG
    Dealer has: #{cards.first} and ???  

    MSG
  end

  def deal_card
    deck.cards.shuffle!.pop
  end
end

class Deck
  include Joinable

  CARD_VALUES = {
    '2' => 2,
    '3' => 3,
    '4' => 4,
    '5' => 5,
    '6' => 6,
    '7' => 7,
    '8' => 8,
    '9' => 9,
    '10' => 10,
    'J' => 10,
    'Q' => 10,
    'K' => 10,
    'A' => 11
  }

  SUITS = %w(♠ ♥ ♣ ♦)

  attr_accessor :cards

  def initialize
    @cards = reset
  end

  def reset
    self.cards = []

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
    "[#{suit} #{name}]"
    # <<~MSG
    # *-----*
    # |#{suit}    |
    # |     |
    # | #{name}  |
    # |     |
    # |   #{suit} |
    # *-----*
    # MSG
  end

  def ace?
    name == 'A'
  end
end

class Game
  include Displayable, Hand

  DESCRIPTION = <<~MSG
      *~ Welcome to 21! ~*

    ***

      The goal of 21 is to get as close to 21 points as possible, without
    going over. If you go over, it's a "bust" and you lose. The player with the
    highest amount of points without going over wins the round.

      The first player to reach 5 wins is the winner of the match.

      You will be playing against the "dealer". Both you and the dealer are initially
    dealt 2 cards. You can always see all of your cards, but will only see one of
    the dealer's cards.

      The number cards are worth their face value, face cards are
    all worth 10 points, and aces are worth 11, but are only worth one if they cause
    the player to bust.

      On your turn you will be prompted to either "hit" or "stay". Hitting draws
    another card from the deck, while staying means you will compare your current
    and with the dealer's hand, after they take their turn.

    ***

  MSG

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
      players_take_turns
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
    dealer_turn unless player.busted?
  end

  def player_turn
    loop do
      break if player.busted?

      hit_or_stay_prompt == '1' ? player.hit : break
      clear_screen_and_display_game_info
    end

    @winner = 'Dealer' if player.busted?
  end

  def dealer_turn
    until dealer.total >= 17
      dealer.hit
    end

    @winner = 'Player' if dealer.busted?
  end

  def clear_screen_and_display_game_info
    clear
    # [dealer, player].each(&:show_hand)
    puts DESCRIPTION
    dealer.show_initial_hand
    player.show_hand
  end

  def show_result
    clear
    puts DESCRIPTION
    [dealer, player].each(&:show_hand)
    display_winner_message
  end

  def display_winner_message
    prompt "The winner is: #{determine_winner}"
  end

  def determine_winner
    return winner if winner

    if player > dealer
      'Player'
    elsif dealer > player
      'Dealer'
    else
      'Tie'
    end
  end

  def reset
    deck.reset
    reset_hands
    @winner = nil
  end

  def reset_hands
    [dealer, player].each do |participant|
      participant.cards = []
      participant.total = 0
    end
  end
end

Game.new.start
