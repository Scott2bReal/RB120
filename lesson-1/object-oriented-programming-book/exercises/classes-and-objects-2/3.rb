# When running the following code...

class Person
  # attr_reader :name <-- Line that creates the error
  attr_accessor :name # This line fixes the error
  def initialize(name)
    @name = name
  end
end


bob = Person.new("Steve")
p bob.name
bob.name = "Bob"
p bob.name

# We get the following error:
#
# test.rb:9:in `<main>': undefined method `name=' for
  #<Person:0x007fef41838a28 @name="Steve"> (NoMethodError)
#
# Why do we get this error and how do we fix it?
#
# We get this error because the name instance variable only has a getter method
# associated with it. This is because attr_reader was used to create a getter
# method for that attribute. The error can be solved by using attr_accessor
# instead of attr_reader. This will create a getter and setter method, allowing
# reassignment of @name
#

