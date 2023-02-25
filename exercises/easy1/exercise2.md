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

---
Further Exploration

What would happen in this case?

```ruby
name = 42
fluffy = Pet.new(name)
name += 1
puts fluffy.name
puts fluffy
puts fluffy.name
puts name
```

This code "works" because of that mysterious to_s call in Pet#initialize. However, that doesn't explain why this code produces the result it does. Can you?

---

In this case it would output:
```
42
My name is 42.
42
43
```

This is because the `to_s` method returns a new string on objects of classes other than `String`. That explains the first 42 output. The reason it doesn't change for the "My name is 42." part is because the `upcase` method only effects alphabetical characters, thus there is no change in value for `@name`. Finally, the final output of `43` is because the integer 42 that was referenced by the local variable `name` is not effected by the separate string object created by `to_s` and vice versa.
