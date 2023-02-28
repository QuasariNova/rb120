If we have a class such as the one below:

```ruby
class Cat
  @@cats_count = 0

  def initialize(type)
    @type = type
    @age  = 0
    @@cats_count += 1
  end

  def self.cats_count
    @@cats_count
  end
end
```

In the name of the cats_count method we have used self. What does self refer to in this context?

---

Outside of an instance method, self refers to the Class. In this case it would be `Cat` or a subclass of `Cat` that it is referring to. This makes the `self.cats_count` method a class method and can only be called from the class `Cat` or a sublcass of `Cat`.
