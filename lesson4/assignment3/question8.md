If we have this class:

```ruby
class Game
  def play
    "Start the game!"
  end
end
```

And another class:
```ruby
class Bingo
  def rules_of_play
    #rules of play
  end
end
```

What can we add to the Bingo class to allow it to inherit the play method from the Game class?

---

We can add `< Game` after `class Bingo` to make `Bingo` a subclass of `Game`. This will put the `play` method in its method lookup chain since it inherits `Game`.
