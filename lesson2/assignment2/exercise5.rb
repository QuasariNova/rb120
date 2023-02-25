# Continuing with our Person class definition, what does the below code print
# out?

# bob = Person.new("Robert Smith")
# puts "The person's name is: #{bob}"

# This code would output:
# The person's name is: #<Person:0x0000000001a17998>

# This is because we haven't overrideen the to_s method

# ------------------------------------------------------------------------------
# Let's add a to_s method to the class:

# class Person
#   # ... rest of class omitted for brevity

#   def to_s
#     name
#   end
# end

class Person
  attr_accessor(:first_name, :last_name)

  def initialize(full_name)
    self.name = full_name
  end

  def name
    "#{first_name} #{last_name}"
  end

  def name=(full_name)
    full_name = full_name.split
    self.first_name = full_name.first
    self.last_name = full_name.size > 1 ? full_name.last : ""
  end

  def to_s
    name
  end
end

# Now, what does the below output?

bob = Person.new("Robert Smith")
puts "The person's name is: #{bob}"

# This now outputs:
# The person's name is: Robert Smith
