# Consider the following program.

class Pet
  def initialize(name, age)
    @name = name
    @age = age
  end
end

class Cat < Pet
  def initialize(name, age, color)
    super(name, age)
    @color = color
  end

  def to_s
    "My cat #{@name} is #{@age} years old and has #{@color} fur."
  end
end

pudding = Cat.new('Pudding', 7, 'black and white')
butterscotch = Cat.new('Butterscotch', 10, 'tan and white')
puts pudding, butterscotch

# Update this code so that when you run it, you see the following output:

# My cat Pudding is 7 years old and has black and white fur.
# My cat Butterscotch is 10 years old and has tan and white fur.

# An alternative approach to this problem would be to modify the Pet class to
# accept a colors parameter. If we did this, we wouldn't need to supply an
# initialize method for Cat.

# Why would we be able to omit the initialize method? Would it be a good idea
# to modify Pet in this way? Why or why not? How might you deal with some of
# the problems, if any, that might arise from modifying Pet?

# ---
# If we intialize all three instance variables inside of Pet, then we do not
# need to override the initialize method for Cat anymore. Ruby will go down
# the method lookup path looking for the initialize method when invoked by new,
# so Pet's initialize would be called. This is because of the concept of
# inheritance.

# The issue with this is if any other classes inherit from Pet, they would all
# have to be changed if they override the initialize method and use super to
# call Pet's initialize method. You could deal with this to a point by making
# the color parameter have a default parameter, but it may not be necessary for
# every Pet to have this value.
