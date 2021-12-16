module Swim
  def enable_swimming
    @can_swim = true
  end
end

class Dog
  include Swim

  def swim
    "swimming" if @can_swim
  end
end

teddy = Dog.new
teddy.enable_swimming # => must be called to enable swimming
teddy.swim
