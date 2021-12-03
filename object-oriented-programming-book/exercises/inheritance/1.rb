=begin

Create a superclass called Vehicle for your MyCar class to inherit from and move
the behavior that isn't specific to the MyCar class to the superclass. Create a
constant in your MyCar class that stores information about the vehicle that
makes it different from other types of Vehicles.

Then create a new class called MyTruck that inherits from your superclass that
also has a constant defined that separates it from the MyCar class in some
way.

=end

class Vehicle
  attr_accessor :color, :speed
  attr_accessor :year, :model

  def initialize(year, color, model)
      @year = year
      @color = color
      @model = model
      @speed = 0
  end

  def accelerate(speed_increase)
    if speed_increase.negative?
      brake(speed_increase)
    else
      self.speed += speed_increase
      puts "You push down on the gas and your speed increases to #{speed} mph"
    end
  end

  def brake(speed_decrease)
    if speed_decrease.positive?
      accelerate(speed_decrease)
    else
      self.speed += speed_decrease
      puts "You push down on the brake and your speed decreases to #{speed} mph"
    end
  end

  def turn_off
    self.speed = 0
    puts "You turn off the car, and your speed is now #{speed} mph"
  end

  def gas_mileage(miles, gallons)
    puts "The gas mileage is #{miles / gallons}mpg."
  end

  def spray_paint(new_color)
    self.color = new_color
    puts "Your #{model} is now painted the color #{new_color.downcase}!"
  end

  def to_s
    "This car is a #{color} #{model} from #{year}"
  end 
end

class MyCar < Vehicle
  NUMBER_OF_WHEELS = 4
end

class MyTruck < Vehicle
  NUMBER_OF_WHEELS = 18
end

car = MyCar.new(2009, 'blue', 'Toyota Sienna')
puts car
puts car.brake(-5)
puts car.accelerate(10)
puts car.turn_off
puts car.gas_mileage(100, 1)
puts car.spray_paint('green')
puts car.number_of_wheels
