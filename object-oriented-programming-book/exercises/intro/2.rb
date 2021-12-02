=begin

What is a module? What is its purpose? How do we use them with our classes?
Create a module for the class you created in exercise 1 and include it properly.

Modules are a way of defining a behavior that can then be adopted by or "mixed
in" to classes. They are useful in that they can provide those behaviors to
otherwise potentially unrelated classes. They are used in classes by using the
`include` method

=end

module MyModule
  def my_method
    puts "This is my method!"
  end
end

class NewObject
  include MyModule
end

new_object = NewObject.new
new_object.my_method
