In the last question we had the following classes:

```ruby
class Greeting
  def greet(message)
    puts message
  end
end

class Hello < Greeting
  def hi
    greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end
```

If we call Hello.hi we get an error message. How would you fix this?

---

The easiest way to fix it would be to define the `hi` class method inside the `Hello` class. You can do so by using `def self.hi; end`.
