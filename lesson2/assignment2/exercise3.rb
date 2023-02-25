# Now create a smart name= method that can take just a first name or a full
# name, and knows how to set the first_name and last_name appropriately.

# bob = Person.new('Robert')
# bob.name                  # => 'Robert'
# bob.first_name            # => 'Robert'
# bob.last_name             # => ''
# bob.last_name = 'Smith'
# bob.name                  # => 'Robert Smith'

# bob.name = "John Adams"
# bob.first_name            # => 'John'
# bob.last_name             # => 'Adams'

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

bob = Person.new('Robert')
p bob.name                  # => 'Robert'
p bob.first_name            # => 'Robert'
p bob.last_name             # => ''
bob.last_name = 'Smith'
p bob.name                  # => 'Robert Smith'

bob.name = "John Adams"
p bob.first_name            # => 'John'
p bob.last_name             # => 'Adams'
