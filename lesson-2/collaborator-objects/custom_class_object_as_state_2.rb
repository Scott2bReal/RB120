module Jumpable
  def jump
    puts "jumping!"
  end
end

class Person
  attr_accessor :name, :pets

  def initialize(name)
    @name = name
    @pets = []
  end
end

class Bulldog
  include Jumpable
end

class Cat
  include Jumpable
end

bob = Person.new("Robert")

kitty = Cat.new
bud = Bulldog.new

bob.pets << kitty
bob.pets << bud

puts bob.pets

bob.pets.each { |pet| pet.jump }
