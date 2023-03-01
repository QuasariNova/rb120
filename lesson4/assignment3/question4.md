What could you add to this class to simplify it and remove two methods from the class definition while still maintaining the same functionality?

```ruby
class BeesWax
  def initialize(type)
    @type = type
  end

  def type
    @type
  end

  def type=(t)
    @type = t
  end

  def describe_type
    puts "I am a #{@type} of Bees Wax"
  end
end
```

---

We could remove the getter method `type` and the setter method `type=` and replace them with a call to `attr_accessor :type`. This is because these are the default implementations of these accessor methods and `attr_accessor`, when invoked, creates them for you.

```ruby
class BeesWax
  attr_accessor :type

  def initialize(type)
    @type = type
  end

  def describe_type
    puts "I am a #{@type} of Bees Wax"
  end
end
```
