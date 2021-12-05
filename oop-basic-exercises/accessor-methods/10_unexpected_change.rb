# Modify the following code to accept a string containing a first and last name.
# The name should be split into two instance variables in the setter method,
# then joined in the getter method to form a full name.

class Person
  def name=(full_name)
    names = split_name(full_name)
    @first_name = names.first
    @last_name = names.last
  end

  def name
    # [@first_name, @last_name].join(' ')
    "#{@first_name} #{@last_name}"
  end

  private

  def split_name(full_name)
    full_name.split(' ')
  end
end

person1 = Person.new
person1.name = 'John Doe'
puts person1.name
