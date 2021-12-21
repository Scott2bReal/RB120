# Consider the following classes:

# class Car
#   attr_reader :make, :model

#   def initialize(make, model)
#     @make = make
#     @model = model
#   end

#   def wheels
#     4
#   end

#   def to_s
#     "#{make} #{model}"
#   end
# end

# class Motorcycle
#   attr_reader :make, :model

#   def initialize(make, model)
#     @make = make
#     @model = model
#   end

#   def wheels
#     2
#   end

#   def to_s
#     "#{make} #{model}"
#   end
# end

# class Truck
#   attr_reader :make, :model, :payload

#   def initialize(make, model, payload)
#     @make = make
#     @model = model
#     @payload = payload
#   end

#   def wheels
#     6
#   end

#   def to_s
#     "#{make} #{model}"
#   end
# end

# Refactor these classes so they all use a common superclass, and inherit
# behavior as needed.
class Vehicle
  attr_reader :make, :model

  def initialize(make, model)
    @make = make
    @model = model
  end

  def to_s
    "#{make} #{model}"
  end

  def wheels
    self.class::WHEELS
  end
end

class Car < Vehicle
  WHEELS = 4
end

class Motorcycle < Vehicle
  WHEELS = 2
end

class Truck < Vehicle
  WHEELS = 6

  attr_reader :payload

  def initialize(make, model, payload)
    super(make, model)
    @payload = payload
  end
end

# I added the Vehicle superclass that all provided classes subclass from now.
# The attr_readers for :make and :model could be extracted to Vehicle, along
# with the initialize methods from the Car and Motorcycle classes. Because
# Truck#initialize contained more logic, I used super to extract the common
# logic back to Vehicle and kept an initialize method in Truck. I also needed an
# attr_reader for :payload

# For the further exploration, I decided to refactor the wheels methods present
# in each subclass to a constant, WHEELS. My reasoning was that the number of
# wheels for each vehicle type would never change. A possible drawback of this
# implementation is that some vehicles (e.g. boats) do not have wheels, and the
# inclusion of a WHEELS cosntant wouldn't make sense.
