# Take a look at the following code:

class Pet
  attr_reader :name

  def initialize(name)
    @name = name.to_s
  end

  def to_s
    # @name.upcase! This line should be commented out so that there are no
    # surprises
    "My name is #{@name}."
  end
end

name = 42
fluffy = Pet.new(name)
name += 1
puts fluffy.name # => 42
puts fluffy      # My name is 42
puts fluffy.name # => 42
puts name        # => 43

# This code "works" because of that mysterious to_s call in Pet#initialize.
# However, that doesn't explain why this code produces the result it does. Can
# you?

# The instance variable @name is assigned to 42 upon instantiation of the Pet
# object to which fluffy is assigned. Once it has been assigned to 42, @name
# will no longer look to name for a value, and will continue pointing to 42
# until told to do otherwise. This means that even after the local variable name
# is reassigned, @name will continue pointing to 43. This is an example of
# variable scoping rules, more specifically the difference in scope between
# local and instance variables.
