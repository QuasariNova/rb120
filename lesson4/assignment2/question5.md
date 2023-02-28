Which of these two classes would create objects that would have an instance variable and how do you know?

```ruby
class Fruit
  def initialize(name)
    name = name
  end
end

class Pizza
  def initialize(name)
    @name = name
  end
end
```

---
The `Pizza` class would be the one with an instance variable. In this case it would have the instance variable `@name` initialized.

In the `Fruit` class on line 3 we reassign local variable `name` instead of initializing and assigning an instance variable. The reason it works with the `Pizza` class is that on line 9, we use an instance variable. Instance variables start with `@`. So we initialize the instance variable `@name` and we assign it to the object referenced by `name`.

Apparently, you can also call the `instance_variables` method on the instance to check what instance variables have been initialized.
