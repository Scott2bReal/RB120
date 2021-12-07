=begin

Write a class that will display:

ABC
xyz

when the following code is run:
my_data = Transform.new('abc')
puts my_data.uppercase
puts Transform.lowercase('XYZ')

This looks like the characters are being capitalized
=end

class Transform
  attr_reader :string

  def initialize(string)
    @string = string
  end

  def uppercase
    string.upcase
  end

  def self.lowercase(string)
    string.downcase
  end
end

my_data = Transform.new('abc') 
puts my_data.uppercase # == 'ABC'
puts Transform.lowercase('XYZ') # == 'xyz'

=begin

Discussion

This problem is about distinguishing between instance and class methods.

The first line of the test code creates an object from the Transform class,
using a single string argument whose value is 'abc'. We then call the instance
method, uppercase, using the my_data object as the caller. This returns the
value we were passed during initialization in uppercase, which we then print.

Finally, we call the class method lowercase, passing it a value of XYZ.
lowercase converts its argument to lowercase and returns the result, which we
then print.

The solution simply implements the necessary class and methods so the test code
runs and produces the desired result.

Obviously, we need a Transform class, and, since we are calling new with an
argument, we also need an initialize method that takes that argument and stashes
it away in an instance variable. We also define uppercase to simply return the
value of that instance variable in uppercase.

We also need the class method lowercase. Since this is a class method, we must
prefix the method name with self. Unlike uppercase, lowercase must obtain the
string to convert from some source other than an instance variable; class
methods do not have access to instance variables. Our test code uses an
argument, so our method is implemented as one that takes an argument. The method
then returns the value of the argument after converting it to lowercase. Further
Exploration

A class method is also, somewhat confusingly, called a "singleton method" (the
term is used in other contexts as well). We don't recommend learning the details
at this time - it may be more confusing than it is helpful - but you should be
aware that you may encounter this term.

=end
