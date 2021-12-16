class Person
  attr_accessor :name, :age

  def initialize(name, age)
    @name = name
    @age = age
  end
end

class Team
  attr_accessor :name, :members

  def initialize(name)
    @name = name
    @members = []
  end

  def <<(person)
    members.push person
  end

  def +(other_team)
    temp_team = Team.new("Temporary Team")
    temp_team.members = members + other_team.members
    temp_team
  end
end

cowboys = Team.new("Dallas Cowboys")
cowboys << Person.new("Troy", 48)
cowboys << Person.new("Emmitt", 46)
cowboys << Person.new("Michael", 49)

niners = Team.new("San Francisco 49ers")
niners << Person.new("Joe", 59)
niners << Person.new("Jerry", 52)
niners << Person.new("Deion", 47)

dream_team = cowboys + niners
puts dream_team.inspect
