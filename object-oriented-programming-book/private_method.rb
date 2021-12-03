class GoodDog
  DOG_YEARS = 7

  attr_accessor :name, :age

  def initialize(name, age)
    self.name = name
    self.age = age
  end

  def public_disclosure
    "#{name} in human years is #{human_years}."
  end

  private # Anything below this keyword will not be available unless called within this class

  def human_years
    age * DOG_YEARS
  end
end

sparky = GoodDog.new("Sparky", 4)
p sparky.public_disclosure
