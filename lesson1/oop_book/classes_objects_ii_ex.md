1.Add a class method to your MyCar class that calculates the gas mileage of any car.

---

```ruby
class MyCar
  attr_accessor :color
  attr_reader :year

  def self.mileage(gallons, miles)
    miles / gallons
  end

  def initialize(yr, clr, mdl)
    @year = yr
    @color = clr
    @model = mdl
    @speed = 0
  end

  def accelerate(number)
    @speed += number
  end

  def brake(number)
    @speed -= number
  end

  def shut_off
    @speed = 0
  end

  def print_speedometer
    puts "You are currently going #{@speed} mph"
  end

  def spray_paint(clr)
    self.color = clr
  end
end
```

---
2.Override the to_s method to create a user friendly print out of your object.

```ruby
class MyCar
  attr_accessor :color
  attr_reader :year

  def self.mileage(gallons, miles)
    miles / gallons
  end

  def initialize(yr, clr, mdl)
    @year = yr
    @color = clr
    @model = mdl
    @speed = 0
  end

  def accelerate(number)
    @speed += number
  end

  def brake(number)
    @speed -= number
  end

  def shut_off
    @speed = 0
  end

  def print_speedometer
    puts "You are currently going #{@speed} mph"
  end

  def spray_paint(clr)
    self.color = clr
  end

  def to_s
    "#{color} #{year} #{@model}: Currently going #{@speed} mph."
  end
end
```

---
3.When running the following code...

```ruby
class Person
  attr_reader :name
  def initialize(name)
    @name = name
  end
end

bob = Person.new("Steve")
bob.name = "Bob"
```

We get the following error...

```
test.rb:9:in `<main>': undefined method `name=' for
  #<Person:0x007fef41838a28 @name="Steve"> (NoMethodError)
```

Why do we get this error and how do we fix it?

---

The reason is that there is no setter method defined for the instance variable `name`. The call to the `attr_reader` method on line 2 only creates a getter method for `@name`. The easiest way to fix this problem is to change the call to `attr_reader` to instead invoke `attr_accessor`. `attr_accessor` will create both the getter and setter methods for the given name. You can also use the `attr_writer` instead, which only creates a setter method, but this depends on if you need a getter or not.
