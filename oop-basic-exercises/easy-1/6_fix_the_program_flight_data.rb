# Consider the following class definition:

class Flight
  attr_accessor :database_handle

  def initialize(flight_number)
    @database_handle = Database.init
    @flight_number = flight_number
  end
end

# There is nothing technically incorrect about this class, but the definition
# may lead to problems in the future. How can this class be fixed to be
# resistant to future problems?
#
# First thoughts: Change the attr_accessor to attr_reader so that the database
# handle isn't changed later on. Could also add an attr_reader for flight_number
# in case that needs to be accessed by the database
