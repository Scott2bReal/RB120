class Dog
  LEGS = 4
end

class Cat
  def legs
    LEGS
  end
end

kitty = Cat.new
kitty.legs # => NameError: uninitialized constant Cat::LEGS
