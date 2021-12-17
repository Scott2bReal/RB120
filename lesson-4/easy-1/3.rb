=begin

In the last question we had a module called Speed which contained a go_fast
method. We included this module in the Car class as shown below.

=end

module Speed
  def go_fast
    puts "I am a #{self.class} and going super fast!"
  end
end

class Car
  include Speed
  def go_slow
    puts "I am safe and driving slow."
  end
end

=begin

When we called the go_fast method from an instance of the Car class (as shown
below) you might have noticed that the string printed when we go fast includes
the name of the type of vehicle we are using. How is this done?

This is done by the self.class interpolation in the go_fast method. In this
case, go_fast is an instance method, and so the self is referring to the current
object. The class method is called on that object, which returns the class. The
puts method then converts that class name to a string and outputs it to the
console, interpolated into the string passed to it as an argument

=end

small_car = Car.new
small_car.go_fast
# I am a Car and going super fast!
