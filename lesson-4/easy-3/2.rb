# In the last question we had the following classes:

class Greeting
  def greet(message)
    puts message
  end
end

class Hello < Greeting
  def hi
    greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end

# If we call Hello.hi we get an error message. How would you fix this?
#
# I would make a new method called self.hi inside of the Hello class definition.
# This would make available a method named hi that could be called on the Hello
# class itself.
