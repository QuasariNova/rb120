# Complete this program so that it produces the expected output:

class Book
  attr_reader(:author, :title)

  def initialize(author, title)
    @author = author
    @title = title
  end

  def to_s
    %("#{title}", by #{author})
  end
end

book = Book.new("Neil Stephenson", "Snow Crash")
puts %(The author of "#{book.title}" is #{book.author}.)
puts %(book = #{book}.)

# Expected output:

# The author of "Snow Crash" is Neil Stephenson.
# book = "Snow Crash", by Neil Stephenson.

# Further Exploration

# What are the differences between attr_reader, attr_writer, and attr_accessor?

# ---
# attr_reader creates a getter, attr_writer creates a setter, and attr_accessor
# creates both a getter and a setter for each symbol passed.
# ---

# Why did we use attr_reader instead of one of the other two? Would it be okay
# to use one of the others? Why or why not?

# ---
# We only needed a getter in this case, so attr_reader was the best choice. If
# we used attr_writer instead, the code would not work as the getter methods
# would not be generated. We could use the attr_accessor method, but that would
# create setter methods we do not need. It's best to limit interaction strictly
# to what is needed.
# ---

# Instead of attr_reader, suppose you had added the following methods to this
# class:

# def title
#   @title
# end

# def author
#   @author
# end

# Would this change the behavior of the class in any way? If so, how? If not,
# why not? Can you think of any advantages of this code?

# ---
# This would not change the behavior of the class as these methods are what
# attr_reader would generate on its own. The benefit of creating the methods
# yourself is that you could change how the value is given, such as cloning or
# changing it, and it would change the implementation everywhere its called.
