class Animal
  def initialize
  end
end

class Bear < Animal
  def initialize(color)
    super() # If super were invoked here without () it would raise an error
    @color = color
  end
end

bear = Bear.new("black")
p bear
