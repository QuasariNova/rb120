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

Explain what the @@cats_count variable does and how it works. What code would you need to write to test your theory?

---
The `@@cats_count` variable is a class variable that is initialized and set to 0 on line 2.

Inside the `initialize` method defined on lines 4 thoruhg 8, we increment the `@@cats_count` class variable by 1 on line 7. This method is called everytime a `Cat` object is instantiated with `new`.

Since class variables belong to the class and not the objects, it is shared amongst all objects. This means that every time we instantiate a new `Cat` object, we increase the `@@cats_count` class variable by one.

Thankfully, we have a getter method of `@@cats_count` in the `cats_count` class method defined on lines 10 through 12. We can tell this is a class method because its name is prepended by a `self.` This method returns the current value of @@cats_count for the `Cat` class and all its subclasses.

So the easiest way to tell, would be to print the return value of `cats_count` inbetween instantiating `Cat` objects, like this:

```ruby
p Cat.cats_count # => 0
Cat.new nil
p Cat.cats_count # => 1
Cat.new nil
p Cat.cats_count # => 2
Cat.new nil
p Cat.cats_count # => 3
Cat.new nil
p Cat.cats_count # => 4
```
