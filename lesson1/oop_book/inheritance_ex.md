1.Create a superclass called Vehicle for your MyCar class to inherit from and move the behavior that isn't specific to the MyCar class to the superclass. Create a constant in your MyCar class that stores information about the vehicle that makes it different from other types of Vehicles.

Then create a new class called MyTruck that inherits from your superclass that also has a constant defined that separates it from the MyCar class in some way.

---
```ruby
class Vehicle
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

  def spray_paint(clr)
    self.color = clr
  end

  def print_speedometer
    puts "You are currently going #{@speed} mph"
  end

  def to_s
    "#{color} #{year} #{@model}: Currently going #{@speed} mph."
  end
end

class MyCar < Vehicle
  DOORS = 4

  def to_s
    super + "This car has #{DOORS} doors."
  end
end

class MyTruck < Vehicle
  DOORS = 2

  def to_s
    super + "This truck has #{DOORS} doors."
  end
end

```

---
2.Add a class variable to your superclass that can keep track of the number of objects created that inherit from the superclass. Create a method to print out the value of this class variable as well.

---

```ruby
class Vehicle
  attr_accessor :color
  attr_reader :year

  @@number_of_vehicles = 0

  def self.number_of_vehicles
    @@number_of_vehicles
  end

  def self.mileage(gallons, miles)
    miles / gallons
  end

  def initialize(yr, clr, mdl)
    @year = yr
    @color = clr
    @model = mdl
    @speed = 0
    @@number_of_vehicles += 1
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

  def spray_paint(clr)
    self.color = clr
  end

  def print_speedometer
    puts "You are currently going #{@speed} mph"
  end

  def to_s
    "#{color} #{year} #{@model}: Currently going #{@speed} mph."
  end
end
```

---
3.Create a module that you can mix in to ONE of your subclasses that describes a behavior unique to that subclass.

---
```ruby
module Towable
  def tow
    puts "Towing something."
  end
end

class MyTruck < Vehicle
  DOORS = 2

  include Towable

  def to_s
    super + "This truck has #{DOORS} doors."
  end
end
```

---
4.Print to the screen your method lookup for the classes that you have created.

---

```ruby
puts Vehicle.ancestors
puts nil
puts MyCar.ancestors
puts nil
puts MyTruck.ancestors
```

This prints:
```
Vehicle
Object
Kernel
BasicObject

MyCar
Vehicle
Object
Kernel
BasicObject

MyTruck
Towable
Vehicle
Object
Kernel
BasicObject
```

---
5.Move all of the methods from the MyCar class that also pertain to the MyTruck class into the Vehicle class. Make sure that all of your previous method calls are working when you are finished.

---

Already done

---
6. Write a method called age that calls a private method to calculate the age of the vehicle. Make sure the private method is not available from outside of the class. You'll need to use Ruby's built-in Time class to help.

---
```ruby
class Vehicle
  attr_accessor :color
  attr_reader :year

  @@number_of_vehicles = 0

  def self.number_of_vehicles
    @@number_of_vehicles
  end

  def self.mileage(gallons, miles)
    miles / gallons
  end

  def initialize(yr, clr, mdl)
    @year = yr
    @color = clr
    @model = mdl
    @speed = 0
    @@number_of_vehicles += 1
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

  def spray_paint(clr)
    self.color = clr
  end

  def print_speedometer
    puts "You are currently going #{@speed} mph"
  end

  def to_s
    "#{color} #{year} #{@model}: Currently going #{@speed} mph."
  end

  def age
    "Your #{@model} is #{calculate_age} years old."
  end

  private
  def calculate_age
    Time.now.year - year
  end
end
```

---
7.Create a class 'Student' with attributes name and grade. Do NOT make the grade getter public, so joe.grade will raise an error. Create a better_grade_than? method, that you can call like so...

---

```ruby
class Student
  attr_reader :name

  def initialize(name, grade)
    @name = name
    @grade = grade
  end

  def better_grade_than?(other_student)
    grade > other_student.grade
  end

  protected

  attr_reader :grade
end

joe = Student.new("Joe", 89)
bob = Student.new("Bob", 89)
sally = Student.new("Sally", 97)
susan = Student.new("Susan", 72)

p joe.better_grade_than?(bob)
p joe.better_grade_than?(sally)
p joe.better_grade_than?(susan)

```

---
8.Given the following code...

```ruby
bob = Person.new
bob.hi
```

And the corresponding error message...

```
NoMethodError: private method `hi' called for #<Person:0x007ff61dbb79f0>
from (irb):8
from /usr/local/rvm/rubies/ruby-2.0.0-rc2/bin/irb:16:in `<main>'
```

What is the problem and how would you go about fixing it?

---

The issue is that the instance method `hi` defined in `Person` is defined on a line after a call to the `private` method. This means its a private method. This makes it where it can not be called outside the object. If we moved the definition for `hi` above the call to the `private` method, it would become public method and thus could be called outside the object.
