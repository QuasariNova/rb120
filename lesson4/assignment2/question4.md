If we have a class AngryCat how do we create a new instance of this class?

The AngryCat class might look something like this:

```ruby
class AngryCat
  def hiss
    puts "Hisssss!!!"
  end
end
```

---

The easiest way to create a new instance of the `AngryCat` class is to call the class method `new` from it. `new` creates a new instance of the class it is called from.

```ruby
AngryCat.new
```
