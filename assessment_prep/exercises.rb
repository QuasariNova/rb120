class Fruit
  def compare(other)
    "I am #{type}, while other is #{other.type}"
  end

  protected

  def type
    fruit
  end

  private

  def fruit
    "Fruit"
  end
end

class Apple < Fruit
  protected

  def type
    "Apple"
  end
end

class Orange < Fruit
  private

  def fruit
    "Orange"
  end
end

apple = Apple.new
orange = Orange.new

# What does each line below output and why?

# p apple.compare(orange) # =>
# p orange.compare(apple) # =>

# ==============================================================================

module Greenable
  def is_green
    DECIDUOUS ? "Maybe" : "Yes"
  end
end

class Tree
  DECIDUOUS = true

  include Greenable

  def sheds_leaves?
    DECIDUOUS
  end
end

module Evergreen
  DECIDUOUS = false

  class Spruce < Tree
    def changes_color?
      DECIDUOUS
    end
  end
end

blue_spruce = Evergreen::Spruce.new

# What does each line below output and why?

# p blue_spruce.changes_color? # =>
# p blue_spruce.class::DECIDUOUS # =>
# p blue_spruce.sheds_leaves? # =>
# p blue_spruce.is_green # =>

# ==============================================================================

module Displayable
  def display; end
end

module Inputable
  def input; end
end

module Soundable
  def sound; end
end

module Printable
  def print; end
end

module VRable
  def virtual_reality; end
end

class Electronic
end

class Computer < Electronic
  include Inputable
  include Printable
end

class Desktop < Computer
  include Displayable
  include Soundable
end

# What is the method lookup path Ruby will use as a result to the call to the
# `virtual_reality` method? Explain how we can verify this.

home_computer = Desktop.new
# home_computer.virtual_reality

# ==============================================================================
class Animal
  def initialize(weight)
    @weight = weight
  end
end

class Mammal < Animal
end

class Cat < Mammal
  def initialize(weight, color)
    super
  end
end

# What happens here and why? What method does super call and why?
# cat = Cat.new(10, 'Calico')

# ==============================================================================

class DrawRule
  @@instance = self.new

  def initialize
    @@instance = self
  end

  def self.instance
    @@instance
  end

  def to_s
    "Draw 1"
  end
end

class Draw2 < DrawRule
  def to_s
    "Draw 2"
  end
end

class Draw5 < DrawRule
  def to_s
    "Draw 5"
  end
end

# What is the output of each of the lines calling `puts`? Why?

# puts Draw2.instance # =>
Draw5.new
rule = Draw2.new
# puts Draw5.instance # =>
Draw5.new
# puts rule.class.instance # =>
