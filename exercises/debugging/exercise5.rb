# You started writing a very basic class for handling files. However, when you
# begin to write some simple test code, you get a NameError. The error message
# complains of an uninitialized constant File::FORMAT.

# What is the problem and what are possible ways to fix it?

# The issue is lexical scope. The FORMAT constant is not defined in File, but
# we reference it in File#to_s. Ruby looks in context to where it is in the
# source code first, which File does not initialize it. It next looks outside
# File, but that is the top level, so it does not find it there. It then checks
# inheritance, but File does not inherit a class that defines FORMAT. It then
# Then it checks the top level, but it does not find it there. Thus, we get our
# NameError.

# The way to fix it is to reference the class of the object calling to_s so
# that Ruby knows where to find it.

class File
  attr_accessor :name, :byte_content

  def initialize(name)
    @name = name
  end

  alias_method :read,  :byte_content
  alias_method :write, :byte_content=

  def copy(target_file_name)
    target_file = self.class.new(target_file_name)
    target_file.write(read)

    target_file
  end

  def to_s
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
