class GoodDog
  def initialize(n, h, w)
    @name = n
    @height = h
    @weight = w
  end

=begin

  def name=(name)
    @name = name
  end

  def name
    @name
  end

  The getter and setter methods defined above can be refactored using
  the the attr_accessor method as follows:
=end

  attr_accessor :name, :height, :weight

  def speak
    # The use of a getter and setter method means that we don't need to
    # reference the instance variable directly as commented below, but can
    # instead call those methods as a way of interacting with the instance
    # variable
    #
    # "#{@name} says Arf!"
    "#{name} says Arf!"
  end

  def change_info(n, h, w)
    self.name = n
    self.height = h
    self.weight = w
  end

  def info
    "#{name} weighs #{weight} and is #{height} tall."
  end
end

sparky = GoodDog.new("Sparky", '12 inches', '10 lbs')
puts sparky.info

sparky.change_info('Spartacus', '24 inches', '45 lbs')
puts sparky.info

#sparky = GoodDog.new("Sparky")
#puts sparky.speak
#puts sparky.name
#sparky.name = "Spartacus"
