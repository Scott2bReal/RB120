=begin

Add an accessor method to your MyCar class to change and view the color of your
car. Then add an accessor method that allows you to view, but not modify, the
year of your car.

=end

class MyCar
  attr_accessor :color
  attr_reader :year

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
      @speed += speed_increase
      puts "You push down on the gas and your speed increases to #{@speed} mph"
    end
  end

  def brake(speed_decrease)
    if speed_decrease.positive?
      accelerate(speed_decrease)
    else
      @speed += speed_decrease
      puts "You push down on the brake and your speed decreases to #{@speed} mph"
    end
  end

  def turn_off
    @speed = 0
    puts "You turn off the car, and your speed is now #{@speed} mph"
  end
end
