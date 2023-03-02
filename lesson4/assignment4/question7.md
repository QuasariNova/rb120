What is used in this class but doesn't add any value?

```ruby
class Light
  attr_accessor :brightness, :color

  def initialize(brightness, color)
    @brightness = brightness
    @color = color
  end

  def self.information
    return "I want to turn on the light with a brightness level of super high and a color of green"
  end

end
```

---

~~I believe the class method `information` does not add any value. The string it returns seems to want to use the data from the instance variables `@brightness and @color`, but it can not because it is a class method.~~

Aparently its the return inside the class method `information`.
This is superfluous because it is the last line of the method, thus will be returned implicitly anyway.
