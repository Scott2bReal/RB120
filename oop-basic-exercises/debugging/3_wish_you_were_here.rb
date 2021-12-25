# On lines 37 and 38 of our code, we can see that grace and ada are located at
# the same coordinates. So why does line 39 output false? Fix the code to
# produce the expected output.

class Person
  attr_reader :name
  attr_accessor :location

  def initialize(name)
    @name = name
  end

  def teleport_to(latitude, longitude)
    @location = GeoLocation.new(latitude, longitude)
  end
end

class GeoLocation
  attr_reader :latitude, :longitude

  def initialize(latitude, longitude)
    @latitude = latitude
    @longitude = longitude
  end

  def to_s
    "(#{latitude}, #{longitude})"
  end

  def ==(other_location)
    [latitude, longitude] == [other_location.latitude, other_location.longitude]
  end
end

# Example

ada = Person.new('Ada')
ada.location = GeoLocation.new(53.477, -2.236)

grace = Person.new('Grace')
grace.location = GeoLocation.new(-33.89, 151.277)

ada.teleport_to(-33.89, 151.277)

puts ada.location                   # (-33.89, 151.277)
puts grace.location                 # (-33.89, 151.277)
puts ada.location == grace.location # expected: true
                                    # actual: false

# The == method checks to see whether the compared objects are in fact the exact
# same object, with the same object ID. The location state of grace and ada are
# both set to GeoLocation objects with the same values, but these objects have
# different object IDs. This can be fixed by overriding the == method with a
# custom one, as demonstrated.
