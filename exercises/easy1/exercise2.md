Take a look at the following code:

```ruby
class Pet
  attr_reader :name

  def initialize(name)
    @name = name.to_s
  end

  def to_s
    @name.upcase!
    "My name is #{@name}."
  end
end

name = 'Fluffy'
fluffy = Pet.new(name)
puts fluffy.name
puts fluffy
puts fluffy.name
puts name
```

What output does this code print? Fix this class so that there are no surprises waiting in store for the unsuspecting developer.

---

This code outputs:
```
Fluffy
My name is FLUFFY.
FLUFFY
FLUFFY
```

This is because we mutate the object referenced by the instance variable `@name` inside the `to_s` method. So when we invoke `to_s` by passing `fluffy` to the `puts` method on line 17, we are mutating the string referenced by both `@name` and the local variable `name`.

To fix this, we just need to change the `to_s` method:

```ruby
class Pet
  # code removed for brevity.

  def to_s
    "My name is #{@name.upcase}."
  end
end
```
