class Person
  attr_accessor :name, :pet

  def initialize(name)
    @name = name
  end
end

class Bulldog
  def speak
    puts "bark!"
  end

  def fetch
    puts "fetching!"
  end
end

bob = Person.new('Bob')
bud = Bulldog.new

bob.pet = bud
bob.pet.speak
bob.pet.fetch
