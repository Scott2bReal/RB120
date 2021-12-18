# If I have the following class:

class Television
  def self.manufacturer
    # method logic
  end

  def model
    # method logic
  end
end

# Which one of these is a class method (if any) and how do you know? How would
# you call a class method?
#
# The class method is defined by prepending self to the method name. In this
# case, manufacturer is a class method. It can be called on the class itself

Television.manufacturer
