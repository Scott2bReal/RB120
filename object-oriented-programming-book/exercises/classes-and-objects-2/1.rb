=begin

Add a class method to your MyCar class that calculates the gas mileage of your
car

=end

class MyCar
  attr_accessor :color, :speed
  attr_reader :year, :model

  def self.gas_mileage(miles, gallons)
    puts "The gas mileage is #{miles / gallons}."
  end

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

  def spray_paint(new_color)
    self.color = new_color
    puts "Your #{model} is now painted the color #{new_color.downcase}!"
  end
end

MyCar.gas_mileage(2, 0.03)
my_car = MyCar.new(2009, "blue", "Toyota Sienna")
my_car.spray_paint("green")
