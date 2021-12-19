=begin

Write a method called age that calls a private method to calculate the age of
the vehicle. Make sure the private method is not available from outside of the
class. You'll need to use Ruby's built-in Time class to help.

=end

module Towable
  def can_tow?
    true
  end
end

class Vehicle
  @@number_of_vehicles = 0

  attr_accessor :color, :speed
  attr_accessor :year, :model

  def initialize(year, color, model)
      @year = year
      @color = color
      @model = model
      @speed = 0
      @@number_of_vehicles += 1
  end

  def number_of_vehicles
    puts "There are #{@@number_of_vehicles} vehicles"
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
    "This vehicle is a #{color} #{model} from #{year}"
  end 

  def age
    current_time = Time.new

    age = current_time.year - self.year
    "This #{color} #{model} is #{age} years old"
  end
end

class MyCar < Vehicle
  NUMBER_OF_WHEELS = 4
end

class MyTruck < Vehicle
  include Towable
  NUMBER_OF_WHEELS = 18
end

van = MyCar.new(2009, 'blue', 'Toyota Sienna')
puts van.age
