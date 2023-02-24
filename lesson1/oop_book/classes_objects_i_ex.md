1. Create a class called MyCar. When you initialize a new instance or object of the class, allow the user to define some instance variables that tell us the year, color, and model of the car. Create an instance variable that is set to 0 during instantiation of the object to track the current speed of the car as well. Create instance methods that allow the car to speed up, brake, and shut the car off.

---

```ruby
class MyCar
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
end
```
---
2.Add an accessor method to your MyCar class to change and view the color of your car. Then add an accessor method that allows you to view, but not modify, the year of your car.

```ruby
class MyCar
  attr_accessor :color
  attr_reader :year

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
end
```

---
3.You want to create a nice interface that allows you to accurately describe the action you want your program to perform. Create a method called spray_paint that can be called on an object and will modify the color of the car.

```ruby
class MyCar
  attr_accessor :color
  attr_reader :year

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
