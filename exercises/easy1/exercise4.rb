# Complete this program so that it produces the expected output:

class Book
  attr_accessor(:author, :title)

  def to_s
    %("#{title}", by #{author})
  end
end

book = Book.new
book.author = "Neil Stephenson"
book.title = "Snow Crash"
puts %(The author of "#{book.title}" is #{book.author}.)
puts %(book = #{book}.)

# Expected output:

# The author of "Snow Crash" is Neil Stephenson.
# book = "Snow Crash", by Neil Stephenson.


# Further Exploration

# What do you think of this way of creating and initializing Book objects? (The
# two steps are separate.) Would it be better to create and initialize at the
# same time like in the previous exercise? What potential problems, if any, are
# introduced by separating the steps?

# ---
# I prefer to create and initialize at the same time like the previous exercise.
# Though see both patterns as valid. The main reason why I think that creating
# and initializing in the case is better is that a book will have a title and
# an author when its created. If we were to call to_s without having initialized
# the state, we would get:

# "", by

# So you run the chance of trying to use unitialized instance variables if you
# when invoking an instance method if you don't manually initialize the instance
# variables through setters.
