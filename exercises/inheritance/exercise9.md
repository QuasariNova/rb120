Using the following code, determine the lookup path used when invoking bird1.color. Only list the classes or modules that were checked by Ruby when searching for the #color method.

```ruby
module Flyable
  def fly
    "I'm flying!"
  end
end

class Animal
  attr_reader :color

  def initialize(color)
    @color = color
  end
end

class Cat < Animal
end

class Bird < Animal
  include Flyable
end

bird1 = Bird.new('Red')
bird1.color
```

---
The lookup path would look like this:

```
Bird
Flyable
Animal
```

Since the `Animal` class has a method called `color` due to the `attr_reader` method creating it, it ends there.
