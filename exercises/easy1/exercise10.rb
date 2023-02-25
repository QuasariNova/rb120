# Refactor these classes so they all use a common superclass, and inherit
# behavior as needed.

class Vehicle
  attr_reader :make, :model

  def initialize(make, model)
    @make = make
    @model = model
  end

  def to_s
    "#{make} #{model}"
  end
end

class Car < Vehicle
  def wheels
    4
  end
end

class Motorcycle < Vehicle
  def wheels
    2
  end
end

class Truck < Vehicle
  attr_reader :make, :model, :payload

  def initialize(make, model, payload)
    super(make, model)
    @payload = payload
  end

  def wheels
    6
  end
end

# Further Exploration

# Would it make sense to define a wheels method in Vehicle even though all of
# the remaining classes would be overriding it? Why or why not? If you think it
# does make sense, what method body would you write?

# ---
# It could make sense to define the wheels method in Vehicle, but I don't think
# its necessary. This is because we may have other vehicles that have no
# wheels like a boat or a helicopter. If we had to move it, I would make the
# the method body like this:

# def wheels
#   0
# end

# It all depends on what the classes are using the wheels method for.
