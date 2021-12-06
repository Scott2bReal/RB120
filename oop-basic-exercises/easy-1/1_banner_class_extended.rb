=begin

Complete this class so that the test cases shown below work as intended. You are
free to add any methods or instance variables you need. However, do not make the
implementation details public.

Modify this class so new will optionally let you specify a fixed banner width at
the time the Banner object is created. The message in the banner should be
centered within the banner of that width. Decide for yourself how you want to
handle widths that are either too narrow or too wide.

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
  def initialize(message, width=nil)
    @message = message
    @width = width ? width : @message.length
  end

  def to_s
    [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
  end

  private

  def horizontal_rule
    "+-" + ('-' * @width) + "-+"
  end

  def empty_line
    "|" + ((' ' * @width) + '  ') + "|"
  end

  def message_line
    "| #{@message} |"
  end
end

banner = Banner.new("To boldly go where no one has gone before")
puts banner

new_banner = Banner.new("To boldly go where no one has gone before", 20)
