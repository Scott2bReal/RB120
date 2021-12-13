class Person
  attr_accessor :name

  def ==(other)
    name == other.name
  end
end

bob = Person.new
bob.name = "bob"

bob2 = Person.new
bob2.name = "bob"

p bob == bob2     # => false before adding cutom == method
                  # => true after

p bob_copy == bob
p bob == bob_cop  #=> true
