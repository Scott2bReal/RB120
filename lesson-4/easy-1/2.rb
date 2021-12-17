=begin

If we have a Car class and a Truck class and we want to be able to go_fast, how
can we add the ability for them to go_fast using the module Speed? How can you
check if your Car or Truck can now go fast?

I would include the module Speed in each of the classes, and then call the
method Speed#go_fast on them to check if they could go fast

=end

module Speed
  def go_fast
    puts "I am a #{self.class} and going super fast!"
  end
end

class Car
  include Speed # include this line

  def go_slow
    puts "I am safe and driving slow."
  end
end

class Truck
  include Speed # include this line

  def go_very_slow
    puts "I am a heavy truck and like going very slow."
  end
end
