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

In the make_one_year_older method we have used self. What is another way we could write this method so we don't have to use the self prefix?

---

If you use the instance variables name `@age` instead of the setter method `self.age` it would work and you wouldn't need to use the self prefix. It is still a good practice to use the setter method though. If your implementation changes, you'd only need to change the accessor methods, instead of every instance of `@age`.
