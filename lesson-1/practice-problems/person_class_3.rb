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

  private
  
  def parse_names(full_name)
    names = full_name.split
    @first_name = names.first
    @last_name = names.size == 1 ? '' : names.last
  end
end

bob = Person.new('Robert')
p bob.name                  # => 'Robert'
p bob.first_name            # => 'Robert'
p bob.last_name             # => ''
bob.last_name = 'Smith'
p bob.name                  # => 'Robert Smith'

bob.name = "John Adams"
p bob.first_name            # => 'John'
p bob.last_name             # => 'Adams'
