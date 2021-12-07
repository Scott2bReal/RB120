=begin

Now that we have a Walkable module, we are given a new challenge. Apparently
some of our users are nobility, and the regular way of walking simply isn't good
enough. Nobility need to strut.

We need a new class Noble that shows the title and name when walk is called:

=end

module Walkable
  def walk
    if is_a?(Noble)
      "#{title} #{name} #{gait} forward."
    else
      puts "#{name} #{gait} forward."
    end
  end
end

class Noble
  include Walkable

  attr_reader :name, :title

  def initialize(name, title)
    @name = name
    @title = title
  end

  private

  def gait
    'struts'
  end
end

class Person
  include Walkable
  attr_reader :name

  def initialize(name)
    @name = name
  end

  private

  def gait
    "strolls"
  end
end

class Cat
  include Walkable
  attr_reader :name

  def initialize(name)
    @name = name
  end

  private

  def gait
    "saunters"
  end
end

class Cheetah
  include Walkable
  attr_reader :name

  def initialize(name)
    @name = name
  end

  private

  def gait
    "runs"
  end
end

mike = Person.new("Mike")
mike.walk
# => "Mike strolls forward"

kitty = Cat.new("Kitty")
kitty.walk
# => "Kitty saunters forward"

flash = Cheetah.new("Flash")
flash.walk
# => "Flash runs forward"

byron = Noble.new("Byron", "Lord")
p byron.walk
# => "Lord Byron struts forward"
