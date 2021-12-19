class GoodDog
  DOG_YEARS = 7

  attr_accessor :name, :age

  def initialize(name, age)
    self.name = name
    self.age = age * DOG_YEARS
  end
end

sparky = GoodDog.new("Sparky", 4)
puts sparky.age
