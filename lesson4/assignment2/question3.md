In the last question we had a module called Speed which contained a go_fast method. We included this module in the Car class as shown below.

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
```

When we called the go_fast method from an instance of the Car class (as shown below) you might have noticed that the string printed when we go fast includes the name of the type of vehicle we are using. How is this done?

```
>> small_car = Car.new
>> small_car.go_fast
I am a Car and going super fast!
```

---

This is due in part to how `self` works inside instance methods. The module `Speed` is defined on lines 1 though 5, in which the `go_fast` method is defined on lines 2 to 5. We know that the `go_fast` method is an instance method because it is not prepended by a class name or `self.`. So when we mix in the `Speed` module to the `Car` class, we are adding the instance method `go_fast` to `Car`.

On line 3 we call `self` which, since its in an instance method, references the instance that called the method. In this case it would be an instance of the `Car` class. We then call the `class` method on the instance of the `Car` class, which would return the `Car` class. `to_s` on it due to it being integrated with string interpolation, thus it returns the string `'Car'`.
