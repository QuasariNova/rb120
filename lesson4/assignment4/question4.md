Given the class below, if we created a new instance of the class and then called to_s on that instance we would get something like "#<Cat:0x007ff39b356d30>"

```ruby
class Cat
  def initialize(type)
    @type = type
  end
end
```

How could we go about changing the to_s output on this method to look like this: I am a tabby cat? (this is assuming that "tabby" is the type we passed in during initialization).

---

We would have to define our own `to_s` method inside the `Cat` class. Due to how Ruby finds its methods with the method lookup chain, Ruby will find the version inside `Cat` first when called on a `Cat` instance.

We can change it like this:

```ruby
class Cat
  def initialize(type)
    @type = type
  end

  def to_s
    "I am a #{@type} cat"
  end
end

mephisto = Cat.new("tabby")
p mephisto.to_s # => "I am a tabby cat"
```
