=begin

Which of these two classes has an instance variable and how do you know?

=end

class Fruit
  def initialize(name)
    name = name
  end
end

class Pizza
  def initialize(name)
    @name = name
  end
end

=begin

Pizza has an instance variable, because it is declared in the initialize method
using the @ symbol

Another way to find out is to instantiate an object of each class, and to call
the instance_variables method on the objects. This method will return an array
containing the instance variables

=end
