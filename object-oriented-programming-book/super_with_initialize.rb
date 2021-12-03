class Animal
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

class GoodDog < Animal
  def initialize(color)
    super # super will pass the argument from this method to the method in
          # the superclass.
    @color = color
  end
end

bruno = GoodDog.new('brown')
p bruno
