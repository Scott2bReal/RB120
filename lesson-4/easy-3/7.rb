# What is used in this class but doesn't add any value?

class Light
  attr_accessor :brightness, :color

  def initialize(brightness, color)
    @brightness = brightness
    @color = color
  end

  def self.information
    return "I want to turn on the light with a brightness level of super high and a color of green"
  end
end

# The return is unecessary, because due to implicit return in ruby, if the
# information method is called on the Light class, that string will
# automatically be returned without the return keyword
