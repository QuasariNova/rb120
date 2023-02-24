Using the following code, determine the lookup path used when invoking cat1.color. Only list the classes that were checked by Ruby when searching for the #color method.

```ruby
class Animal
  attr_reader :color

  def initialize(color)
    @color = color
  end
end

class Cat < Animal
end

class Bird < Animal
end

cat1 = Cat.new('Black')
cat1.color
```

Ruby will use this lookup path til it finds the `#color` method

```
Cat
Animal
```

Since Animal has a method named `color`, it's no longer needs to keep going down the line.
