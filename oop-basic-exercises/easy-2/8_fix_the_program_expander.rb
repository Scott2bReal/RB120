# What is wrong with the following code? What fix(es) would you make?

class Expander
  def initialize(string)
    @string = string
  end

  def to_s
    # self.expand(3)
    expand(3)
  end

  private

  attr_reader :string

  def expand(n)
    # @string * n
    string * n
  end
end

expander = Expander.new('xyz')
puts expander

=begin

I would create a getter method for the instance variable @string, to avoid
directly referencing @string in the `expand` method. I would include this getter
method in the class under the private modifier to obscure the value assigned to
@string from any users. I would also remove the `self` call in the
`Expander#to_s` method as it is redundant

=end
