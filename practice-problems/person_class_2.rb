class Person
  attr_accessor :first_name, :last_name

  def initialize(first_name, last_name='')
    @first_name = first_name
    @last_name = last_name
  end

  def name
    if last_name == ''
      "#{self.first_name}"
    else
      "#{self.first_name} #{self.last_name}"
    end
  end
end

bob = Person.new('Robert')
p bob.name
p bob.first_name
p bob.last_name
bob.last_name = 'Smith'
p bob.name
