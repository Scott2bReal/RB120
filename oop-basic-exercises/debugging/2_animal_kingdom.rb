# The code below raises an exception. Examine the error message and alter the
# code so that it runs without error.

class Animal
  def initialize(diet, superpower)
    @diet = diet
    @superpower = superpower
  end

  def move
    puts "I'm moving!"
  end

  def superpower
    puts "I can #{@superpower}!"
  end
end

class Fish < Animal
  def move
    puts "I'm swimming!"
  end
end

class Bird < Animal
end

class FlightlessBird < Bird
  def initialize(diet, superpower)
    super
  end

  def move
    puts "I'm running!"
  end
end

class SongBird < Bird
  def initialize(diet, superpower, song)
    # super
    # This line should read:
    super(diet, superpower)
    @song = song
  end

  def move
    puts "I'm flying!"
  end
end

# Examples

unicornfish = Fish.new(:herbivore, 'breathe underwater')
penguin = FlightlessBird.new(:carnivore, 'drink sea water')
robin = SongBird.new(:omnivore, 'sing', 'chirp chirrr chirp chirp chirrrr')

# In this example, when a new SongBird object is instantiated, line 1 of
# SongBird#initialize is calling super with no arguments passed in. This
# automatically passes all arguments passed in on instantiation to the
# superclass initialize method, which is only expecting 2 arguments. This raises
# an ArgumentError. This can be fixed by explicitly passing only the arguments
# the superclass method expects, and assigning the remaining instance variable
# to the remaining argument as demonstrated above
#
# Further exploration:
#
# The FlightlessBird#initialize method is superfluous, since it only calls
# super. If it was omitted, the initialize method from Animal would be invoked
# anyway.
