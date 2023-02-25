# Modify the following code so that Hello! I'm a cat! is printed when Cat.
# generic_greeting is invoked.

# class Cat
# end

# Cat.generic_greeting

# Expected output:

# Hello! I'm a cat!

class Cat
  def self.generic_greeting
    puts "Hello! I'm a cat!"
  end
end

kitty = Cat.new
Cat.generic_greeting

# further exploration:

# What happens if you run kitty.class.generic_greeting? Can you explain this
# result?

kitty.class.generic_greeting

# It invokes the method as if it was called like Cat.generic_greeting.
# This is because the #class method returns the class reference, thus is the
# the same as typing it out.
