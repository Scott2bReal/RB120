=begin

Given the following code...

bob = Person.new
bob.hi

And the corresponding error message...

NoMethodError: private method `hi' called for #<Person:0x007ff61dbb79f0>
from (irb):8
from /usr/local/rvm/rubies/ruby-2.0.0-rc2/bin/irb:16:in `<main>'

What is the problem and how would you go about fixing it?

The problem is that the hi method is private, and cannot be accessed outside of
the class. This could be fixed by moving the hi method definition above the
private modifier

=end

class Person
  def hi
    puts "Hello!"
  end

  private

  #def hi
    #puts "Hello!"
  #end
end

bob = Person.new
bob.hi
