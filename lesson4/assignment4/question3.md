When objects are created they are a separate realization of a particular class.

Given the class below, how do we create two different instances of this class with separate names and ages?

```ruby
class AngryCat
  def initialize(age, name)
    @age  = age
    @name = name
  end

  def age
    puts @age
  end

  def name
    puts @name
  end

  def hiss
    puts "Hisssss!!!"
  end
end
```

We would do so like this:

```ruby
mephisto = AngryCat.new(10, "Mephisto")
stormageddon = AngryCat.new(8, "Stormageedon")
```

The `new` class method invokes the `instance` method defined on lines 2 through 5 for us. We just need to pass the two parameters defined for `initialize` as arguments to the `new` class method.
