class Person
  attr_accessor :first_name, :last_name

  def initialize(full_name)
    parse_names(full_name)
  end

  def name
    "#{first_name} #{last_name}".strip
  end

  def name=(new_name)
    parse_names(new_name)
  end

  def to_s
    name
  end

  private
  
  def parse_names(full_name)
    names = full_name.split
    @first_name = names.first
    @last_name = names.size == 1 ? '' : names.last
  end
end

# Continuing with our Person class definition, what does the below print out?

# bob = Person.new('Robert Smith')
# puts "The person's name is #{bob}"

# This will output the string of the object's class name
# --> The person's name is #<Person:0x000055ccae8f1238>

# Let's add a to_s method to the class
# Now what does the following output?

bob = Person.new('Robert Smith')
puts "The person's name is #{bob}"

# This will output:
# The person's name is Robert Smith
