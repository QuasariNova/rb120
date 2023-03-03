If we have these two methods in the Computer class:

```ruby
class Computer
  attr_accessor :template

  def create_template
    @template = "template 14231"
  end

  def show_template
    template
  end
end
```

and

```ruby
class Computer
  attr_accessor :template

  def create_template
    @template = "template 14231"
  end

  def show_template
    self.template
  end
end
```

What is the difference in the way the code works?

---

There is no difference in how the code works. In the first example we are directly calling the instance method `template` which is a getter method for `@template`. In the second example we are referring to our instance with `self` and calling the `template` method on it. Since both were called within an instance method, it was called on this instance anyway. The `self.` is unneeded.
