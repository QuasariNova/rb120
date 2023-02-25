# Behold this incomplete class for constructing boxed banners.

# class Banner
#   def initialize(message)
#   end

#   def to_s
#     [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
#   end

#   private

#   def horizontal_rule
#   end

#   def empty_line
#   end

#   def message_line
#     "| #{@message} |"
#   end
# end

# Complete this class so that the test cases shown below work as intended. You
# are free to add any methods or instance variables you need. However, do not
# make the implementation details public.

# You may assume that the input will always fit in your terminal window.

# Test Cases

# banner = Banner.new('To boldly go where no one has gone before.')
# puts banner
# +--------------------------------------------+
# |                                            |
# | To boldly go where no one has gone before. |
# |                                            |
# +--------------------------------------------+

# banner = Banner.new('')
# puts banner
# +--+
# |  |
# |  |
# |  |
# +--+

# Further Exploration:
# Modify this class so new will optionally let you specify a fixed banner width
# at the time the Banner object is created. The message in the banner should be
# centered within the banner of that width. Decide for yourself how you want to
# handle widths that are either too narrow or too wide.

class Banner
  MIN_WIDTH = 0
  MAX_WIDTH = 76 # 80 - 4 for "|   |" makes max 76

  def initialize(message, width = nil)
    @message = message
    set_width(width)
  end

  def to_s
    ([horizontal_rule, empty_line] + message_lines +
     [empty_line, horizontal_rule]).join("\n")
  end

  private

  attr_reader :width

  def set_width(width)
    range = (MIN_WIDTH..MAX_WIDTH)
    @width = if range.cover?(width) && !width.zero?
               width
             elsif range.cover?(@message.size)
               @message.size
             elsif @message.size < MIN_WIDTH
               MIN_WIDTH
             else
               MAX_WIDTH
             end
  end

  def horizontal_rule
    "+ #{'-' * width} +"
  end

  def empty_line
    "| #{' ' * width} |"
  end

  def message_lines
    split_message.map { |line| "| #{line} |" }
  end

  def split_message
    lines = []
    last_start = 0
    while last_start < @message.size
      remaining_width = @message.size - last_start
      length = [remaining_width, @width].min

      # If we are max size, we search for a space character, so that we don't
      # break up words. If there is no space, we break up the string anyway.
      if remaining_width > @width && @message[last_start, length].include?(' ')
        until @message[last_start + length] == ' '
          length -= 1
        end
      end

      lines << @message[last_start, length].center(@width)
      last_start = last_start + length
      last_start += 1 if @message[last_start] == ' ' # can't start on a space
    end

    lines
  end
end

banner = Banner.new('To boldly go where no one has gone before.')
puts banner

banner = Banner.new('To boldly go where no one has gone before.', 32)
puts banner

banner = Banner.new('AAAAAAAAAAAAAASSSSSSSSSSSSSSSSSSSSSSSSSSDDDDDDDDDDDDDDDDDDDDDDDDDFFFFFFFFFFFFFFFFFFFFFFFFFFFFGGGGGGGGGGGGGGGGGGGGGGGG')
puts banner

banner = Banner.new("Sometimes we make the process more complicated than we need to. We will never make a journey of a thousand miles by fretting about how long it will take or how hard it will be. We make the journey by taking each day step by step and then repeating it again and again until we reach our destination. ― Joseph B. Wirthlin")
puts banner

banner = Banner.new('Pigs in a blanket, so sweet', 10)
puts banner

banner = Banner.new('hi', 0)
puts banner

banner = Banner.new('')
puts banner
