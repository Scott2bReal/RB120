=begin

What could we add to the class below to access the instance variable @volume?

=end

class Cube
  attr_accessor :volume # Solution

  def initialize(volume)
    @volume = volume
  end
end
