If we have the class below, what would you need to call to create a new instance of this class.

```ruby
class Bag
  def initialize(color, material)
    @color = color
    @material = material
  end
end
```

---

The `initialize` method is called by the class method `new` passing each argument passed to `new` as an argument to `initialize`. Since the `initialize` method defined on line 2 requires two parameters, you are required to pass two parameters to new. You could do so like this:

```ruby
guchi = Bag.new 'Red', 'Leather'
```
