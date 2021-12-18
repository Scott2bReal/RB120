# How do you find where Ruby will look for a method when that method is called?
# How can you find an object's ancestors?
#
# The method lookup path and object's ancestors can be displayed by calling the
# ancestors method on a class.

module Taste
  def flavor(flavor)
    puts "#{flavor}" 
  end
end

class Orange
  include Taste
end

class HotSauce
  include Taste
end

puts Orange.ancestors

# What is the lookup chain for Orange and HotSauce?
#
# For Orange, the lookup chain is: Orange > Taste > Object > Kernel >
# BasicObject
#
# For HotSauce, the lookup chain is: HotSauce > Taste > Object > Kernel >
# BasicObject
