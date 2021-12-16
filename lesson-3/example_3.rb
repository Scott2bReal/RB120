class Person
  @name = 'bob'

  def get_name
    @name
  end
end

bob = Person.new
bob.get_name # => nil
