=begin

What is the default return value of to_s when invoked on an object? Where could
you go to find out if you want to be sure?

I don't know the answer off the top of my head, so I would look at the Ruby
documentation for Object#to_s

The default to_s return value when called on an object is the object's class,
and an encoding of the object id.

=end
