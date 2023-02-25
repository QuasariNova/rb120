# Using the class definition from step #3, let's create a few more people --
# that is, Person objects.

# bob = Person.new('Robert Smith')
# rob = Person.new('Robert Smith')

# If we're trying to determine whether the two objects contain the same name,
# how can we compare the two objects?

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
end

bob = Person.new('Robert Smith')
rob = Person.new('Robert Smith')

puts bob.name == rob.name # We just compare return values of the getter method
