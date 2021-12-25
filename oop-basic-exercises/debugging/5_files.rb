# You started writing a very basic class for handling files. However, when you
# begin to write some simple test code, you get a NameError. The error message
# complains of an uninitialized constant File::FORMAT.

# What is the problem and what are possible ways to fix it?

class File
  attr_accessor :name, :byte_content

  def initialize(name)
    @name = name
  end

  # rubocop:disable Style/Alias
  alias_method :read,  :byte_content
  alias_method :write, :byte_content=
  # rubocop:enable Style/Alias

  def copy(target_file_name)
    target_file = self.class.new(target_file_name)
    target_file.write(read)

    target_file
  end

  def to_s
    # "#{name}.#{FORMAT}"
    # This line should read:
    "#{name}.#{self.class::FORMAT}"
  end
end

class MarkdownFile < File
  FORMAT = :md
end

class VectorGraphicsFile < File
  FORMAT = :svg
end

class MP3File < File
  FORMAT = :mp3
end

# Test

blog_post = MarkdownFile.new('Adventures_in_OOP_Land')
blog_post.write('Content will be added soon!'.bytes)

copy_of_blog_post = blog_post.copy('Same_Adventures_in_OOP_Land')

puts copy_of_blog_post.is_a? MarkdownFile     # true
puts copy_of_blog_post.read == blog_post.read # true

puts blog_post

# The constant is uninitialized inside of File because it is only initialized
# within subclasses of File. The solution is to change the reference to FORMAT
# within File#to_s to read as demonstrated. This is an example of constants
# having lexical scope in Ruby. The location in code of the constant definition
# must be explicitly referenced if referencing the constant from outside of the
# class in which it is defined.
