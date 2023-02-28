If we have a Car class and a Truck class and we want to be able to go_fast, how can we add the ability for them to go_fast using the module Speed? How can you check if your Car or Truck can now go fast?

```ruby
module Speed
  def go_fast
    puts "I am a #{self.class} and going super fast!"
  end
end

class Car
  def go_slow
    puts "I am safe and driving slow."
  end
end

class Truck
  def go_very_slow
    puts "I am a heavy truck and like going very slow."
  end
end
```

---

To add the abitity to `go_fast`, we just need to mixin the `Speed` module to both the `Car` and `Truck` classes. We do that by using `include Speed` inside the class body. It would look like this:

```ruby
module Speed
  def go_fast
    puts "I am a #{self.class} and going super fast!"
  end
end

class Car
  include Speed

  def go_slow
    puts "I am safe and driving slow."
  end
end

class Truck
  include Speed

  def go_very_slow
    puts "I am a heavy truck and like going very slow."
  end
end
```

The easiest way to check if your `Car` or `Truck` can now `go_fast` is to attempt to invoke the method on an instance of `Car` or `Truck`. Something like this:

```ruby
Car.new.go_fast # => I am a Car and going super fast!
Truck.new.go_fast # =>I am a Truck and going super fast!
```
