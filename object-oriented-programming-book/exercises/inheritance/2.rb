=begin

Add a class variable to your superclass that can keep track of the number of
objects created that inherit from the superclass. Create a method to print out
the value of this class variable as well.

=end

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

