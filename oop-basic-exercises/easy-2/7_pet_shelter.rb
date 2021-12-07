=begin

Consider the following code:

butterscotch = Pet.new('cat', 'Butterscotch')
pudding      = Pet.new('cat', 'Pudding')
darwin       = Pet.new('bearded dragon', 'Darwin')
kennedy      = Pet.new('dog', 'Kennedy')
sweetie      = Pet.new('parakeet', 'Sweetie Pie')
molly        = Pet.new('dog', 'Molly')
chester      = Pet.new('fish', 'Chester')

phanson = Owner.new('P Hanson')
bholmes = Owner.new('B Holmes')

shelter = Shelter.new
shelter.adopt(phanson, butterscotch)
shelter.adopt(phanson, pudding)
shelter.adopt(phanson, darwin)
shelter.adopt(bholmes, kennedy)
shelter.adopt(bholmes, sweetie)
shelter.adopt(bholmes, molly)
shelter.adopt(bholmes, chester)
shelter.print_adoptions
puts "#{phanson.name} has #{phanson.number_of_pets} adopted pets."
puts "#{bholmes.name} has #{bholmes.number_of_pets} adopted pets."

Write the classes and methods that will be necessary to make this code run, and print the following output:

P Hanson has adopted the following pets:
a cat named Butterscotch
a cat named Pudding
a bearded dragon named Darwin

B Holmes has adopted the following pets:
a dog named Molly
a parakeet named Sweetie Pie
a dog named Kennedy
a fish named Chester

P Hanson has 3 adopted pets.
B Holmes has 4 adopted pets.

The order of the output does not matter, so long as all of the information is presented.

Algorithm/Mental Model:
  - Pets look like they need at least name and animal attributes, 
      - pet should get to_s which displays animal and name 
  - Owner needs a name on init, and have a number of pets
  - Shelters can adopt and print adoptions, have attributes human and animal
    - print_adoptions method needs: Owner name, Owner number_of_pets
    - adopt method should 

=end

class Pet
  attr_reader :animal_type, :name

  def initialize(animal_type, name)
    @animal_type = animal_type
    @name = name
  end

  def to_s
    "a #{animal_type} named #{name}"
  end
end

class Owner
  attr_accessor :pets
  attr_reader :name

  def initialize(name)
    @name = name
    @pets = []
  end

  def number_of_pets
    pets.size
  end
end

class Shelter
  attr_accessor :humans

  def initialize
    @humans = []
  end

  def adopt(owner, pet)
    @humans << owner unless humans.include?(owner)
    owner.pets << pet
  end

  def print_adoptions
    humans.each do |owner|
      puts "#{owner.name} has adopted the following pets:"

      owner.pets do |pet|
        puts pet
      end

      puts "\n"
    end
  end
end

butterscotch = Pet.new('cat', 'Butterscotch')
pudding      = Pet.new('cat', 'Pudding')
darwin       = Pet.new('bearded dragon', 'Darwin')
kennedy      = Pet.new('dog', 'Kennedy')
sweetie      = Pet.new('parakeet', 'Sweetie Pie')
molly        = Pet.new('dog', 'Molly')
chester      = Pet.new('fish', 'Chester')

phanson = Owner.new('P Hanson')
bholmes = Owner.new('B Holmes')

shelter = Shelter.new
shelter.adopt(phanson, butterscotch)
shelter.adopt(phanson, pudding)
shelter.adopt(phanson, darwin)
shelter.adopt(bholmes, kennedy)
shelter.adopt(bholmes, sweetie)
shelter.adopt(bholmes, molly)
shelter.adopt(bholmes, chester)
shelter.print_adoptions
puts "#{phanson.name} has #{phanson.number_of_pets} adopted pets."
puts "#{bholmes.name} has #{bholmes.number_of_pets} adopted pets."
