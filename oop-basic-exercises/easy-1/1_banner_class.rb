=begin

Complete this class so that the test cases shown below work as intended. You are
free to add any methods or instance variables you need. However, do not make the
implementation details public.

You may assume that the input will always fit in your terminal window.

Input: A string object (message)
Output: The banner formatted as in the examples

Algorithm:
  - Horizontal rule should start and end with +-, then contain as many - as
  there are characters in message

  - Empty line should start and end with |, and contain as many spaces as size
  of message plus 2

=end

class Banner
  def initialize(message)
    @message = message
  end

  def to_s
    [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
  end

  private

  def horizontal_rule
    "+-" + ('-' * @message.length) + "-+"
  end

  def empty_line
    "|" + ((' ' * @message.length) + '  ') + "|"
  end

  def message_line
    "| #{@message} |"
  end
end

banner = Banner.new('To boldly go where no one has gone before.')
puts banner
=begin

Should output:

+--------------------------------------------+
|                                            |
| To boldly go where no one has gone before. |
|                                            |
+--------------------------------------------+

=end
empty_banner = Banner.new('')
puts empty_banner
=begin

Should output:

+--+
|  |
|  |
|  |
+--+

=end
