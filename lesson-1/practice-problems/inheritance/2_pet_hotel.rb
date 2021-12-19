# Create a new class called Cat, which can do everything a dog can, except swim
# or fetch. Assume the methods do the exact same thing. Hint: don't just copy
# and paste all methods in Dog into Cat; try to come up with some class
# hierarchy.

class Mammal
  def run
    'running!'
  end

  def jump
    'jumping!'
  end
end

class Dog < Mammal
  def speak
    'bark!'
  end

  def swim
    'swimming!'
  end

  def fetch
    'fetching!'
  end
end

class Cat < Mammal
  def speak
    'meow!'
  end
end
