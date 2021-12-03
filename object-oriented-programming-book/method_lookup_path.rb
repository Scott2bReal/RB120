module Walkable
  def walk
    "I'm walking"
  end
end

module Swimmable
  def swim
    "I'm swimming"
  end
end

module Climbable
  def climb
    "I'm climbing"
  end
end

class Animal
  include Walkable

  def speak
    "I'm an animal, and I speak!"
  end
end

puts "---Animal method lookup---"
puts Animal.ancestors
fido = Animal.new
puts fido.speak
puts fido.walk
puts fido.swim # Raises a NoMethodError because Swimmable is not in the method lookup path for Animal