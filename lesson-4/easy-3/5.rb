# If I have the following class:

class Television
  def self.manufacturer
    # method logic
  end

  def model
    # method logic
  end
end

tv = Television.new # new Television object is created
tv.manufacturer # NoMethodError
tv.model # Method logic of Television#model is executed

Television.manufacturer # Method logic of Television#manufacturer is executed
Television.model # NoMethodError
