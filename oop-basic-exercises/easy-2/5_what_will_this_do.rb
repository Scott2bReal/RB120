# What will the following code print?

class Something
  def initialize
    @data = 'Hello'
  end

  def dupdata
    @data + @data
  end

  def self.dupdata
    'ByeBye'
  end
end

thing = Something.new
puts Something.dupdata
puts thing.dupdata

=begin

In this code a new `Something` object is assigned to the local variable `thing`.
On the next line the method `dupdata` is called onthe class `Something`. The
return value of that method call is passed to the `puts` method on that same
line.  This will output 'ByeBye' and return `nil`. On the next line, `dupdata` is called on the `Something` object assigned to the local variable `thing`. This will use the instance method `dupdata` from the `Something` class, which returns the result of adding the value assigned to the instance variable `@data` with itself.

The code will print:

'ByeBye'
'HelloHello'

=end
