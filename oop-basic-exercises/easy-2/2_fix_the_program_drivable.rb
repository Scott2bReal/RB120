=begin

Correct the following program so it will work properly. Assume that the Car
class has a complete implementation; just make the smallest possible change to
ensure that cars have access to the drive method.

=end

module Drivable
# def self.drive
  def drive # Replace above commented line with this
  end
end

class Car
  include Drivable
end

bobs_car = Car.new
bobs_car.drive
