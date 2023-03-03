How could you change the method name below so that the method name is more clear and less repetitive?

```ruby
class Light
  attr_accessor :brightness, :color

  def initialize(brightness, color)
    @brightness = brightness
    @color = color
  end

  def light_status
    "I have a brightness level of #{brightness} and a color of #{color}"
  end

end
```

---

Changing the method `light_status` to just `status` makes sense. The class is already named `Light`, so a method named `status` already delivers that it is returning the status of the `Light` class. The variable name storing the object will likely refer to lights somehow due to the object being related to lights, thus it should be clear what it is doing.
