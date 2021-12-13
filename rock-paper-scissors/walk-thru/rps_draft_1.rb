class Player
  def initialize
    # maybe a 'name'? what about a 'move'?
  end

  def choose

  end
end

class Move
  def initialize
    # seems like we need something to keep track
    # of the choice... a move object can be 'paper', 'rock' etc...
  end
end

class Rule
  def initialize
    # not sure what the 'state' of a rule object should be
  end
end

# Needs an "orchestration engine", which is where the actual flow of the program
# should take place.

class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Player.new
    @computer = Player.new
  end

  def play
    display_welcome_message
    human.choose
    computer.choose
    display_winner
    display_goodbye_message
  end
end

RPSGame.new.play
