If we have this class:

```ruby
class Game
  def play
    "Start the game!"
  end
end

class Bingo < Game
  def rules_of_play
    #rules of play
  end
end
```

What would happen if we added a `play` method to the `Bingo` class, keeping in mind that there is already a method of this name in the `Game` class that the `Bingo` class inherits from.

---

The `play` method inside `Bingo` would override the `play` method that `Bingo` inherited from `Game`. This is because of how the method lookup chain works in Ruby. Ruby always starts looking for a method inside the class that the object calling it was instantiated from. So, Ruby would never look at the `Game` class to find the `play` method if you defined a `play` method inside `Bingo` definition.
