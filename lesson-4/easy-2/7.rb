# If we have a class such as the one below:

class Cat
  @@cats_count = 0

  def initialize(type)
    @type = type
    @age = 0
    @@cats_count += 1
  end

  def self.cats_count
    @@cats_count
  end
end

# Explain what the @@cats_count variable does and how it works. What code would
# you need to write to test your theory?
#
# The @@cats_count variable counts the number of Cat objects that are created.
# Whenever a Cat object is instantiated, the value assigned to @@cats_count is
# incremented by one. Code to test this functionality would be:

puts Cat.cats_count
cat1 = Cat.new('calico')
puts Cat.cats_count
