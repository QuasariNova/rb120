If I have the following class:

```ruby
class Television
  def self.manufacturer
    # method logic
  end

  def model
    # method logic
  end
end
```

Which one of these is a class method (if any) and how do you know? How would you call a class method?

The `self.manufacturer` method defined on lines 2 through 4 is a class method. You can tell because it is prepended by `self.` `self` outside of an instance method always refers to the class it is in, thus this is saying that the `manufacturer` method belongs to the class `Television`.

You may call this method by using its class name then calling the method like this:

```ruby
Television.manufacturer
```
