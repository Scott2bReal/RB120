# If we have these two methods in the Computer class:

# class Computer
#   attr_accessor :template
#
#   def create_template
#     @template = "template 14231"
#   end
#
#   def show_template
#     template
#   end
# end
#
# class Computer
#   attr_accessor :template
#
#   def create_template
#     self.template = "template 14231"
#   end
#
#   def show_template
#     self.template
#   end
# end

# Both examples are almost exactly the same, the difference being that in the
# first example, @template is being directly reassigned in create_template,
# whereas in the second the setter method is called.
