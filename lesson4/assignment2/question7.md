If we have a class such as the one below:

```ruby
class Cat
  attr_accessor :type, :age

  def initialize(type)
    @type = type
    @age  = 0
  end

  def make_one_year_older
    self.age += 1
  end
end
```

You can see in the make_one_year_older method we have used self. What does self refer to here?

---

Since the `make_one_year_older` method is not prepended by `Cat.` or `sef.` it is an instance method. `self` refers to the instance that called the method inside instance methods. So this would be the `Cat` or subclass of `Cat` object that called this method.
