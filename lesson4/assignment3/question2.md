We have an Oracle class and a RoadTrip class that inherits from the Oracle class.

```ruby
class Oracle
  def predict_the_future
    "You will " + choices.sample
  end

  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end

class RoadTrip < Oracle
  def choices
    ["visit Vegas", "fly to Fiji", "romp in Rome"]
  end
end
```

What is the result of the following:

```ruby
trip = RoadTrip.new
trip.predict_the_future
```

The return value of `trip.predict_the_future` could be one of the following three values:

- `'You will visit Vegas'`
- `'You will fly to Fiji'`
- `'You will romp in Rome'`

This is because we instantiate a `RoadTrip` object. The `RoadTrip` class is defined on lines 11 to 15 and is a subclass of `Oracle`.

`Oracle` is defined on lines 1 to 9 and defines two instance methods: `predict_the_future` and `choices`. Since `RoadTrip` also defines `choices`, the `RoadTrip` version of `choices` will override the `Oracle` version of it in `RoadTrip` objects.

So when we call `predict_the_future` on the `RoadTrip` object we instantiated, it will call the `choices` defined on line 12 instead of the `choices` defined on line 6.

This is due to how the method lookup works in Ruby. It first checks the class the object is an instance of, the it checks the modules mixed in, then it goes up the inheritance chain in a similar fashion. Due to `choices` being found in `RoadTrip` it does not need to travel out of `RoadTrip` to find the method.
