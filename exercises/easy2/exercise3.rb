# Assume you have the following code:

class House
  include Comparable
  attr_reader :price

  def <=>(other)
    price <=> other.price
  end

  def initialize(price)
    @price = price
  end
end

home1 = House.new(100_000)
home2 = House.new(150_000)
puts "Home 1 is cheaper" if home1 < home2
puts "Home 2 is more expensive" if home2 > home1

# and this output:

# Home 1 is cheaper
# Home 2 is more expensive

# Modify the House class so that the above program will work. You are permitted to define only one new method in House.

# Further Exploration

# Is the technique we employ here to make House objects comparable a good one? (Hint: is there a natural way to compare Houses? Is price the only criteria you might use?)

# ---
# Houses are comparable, but there are so many factors that its hard to rank
# one greater or lesser than another. Price is one criteria, but you also have
# number of beds and baths, sqr feet, floors, access to power, access to water,
# school district, AC, Heating, etc... There is so much to compare that it may
# not be something you want to even compare.
# ---

# What problems might you run into, if any?

# ---
# If the context is price, not much. Other contexts, its pretty hard to define
# an actual comparable.
# ---

#Can you think of any sort of classes where including Comparable is a good idea?

# ---
# Playing Cards. Higher face value = > than other card.
