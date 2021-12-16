class Vehicle
  @@wheels = 4

  def self.wheels
    @@wheels
  end
end

Vehicle.wheels # => 4

class Motorcycle
  @@wheels = 2
end

Motorcycle.wheels # => 2
Vehicle.wheels    # => 2!
