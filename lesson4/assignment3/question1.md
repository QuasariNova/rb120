You are given the following code:

```ruby
class Oracle
  def predict_the_future
    "You will " + choices.sample
  end

  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end
```

What is the result of executing the following code:

```ruby
oracle = Oracle.new
oracle.predict_the_future
```

---

The result would be one of three return values:

- `'You will eat a nice lunch'`
- `'You will take a nap soon'`
- `'You will stay at work late'`

This is because we invoke the `predict_the_future` instance method on the newly instantiated `Oracle` object.

The `predict_the_future` is defined on lines 2 to 4. On line 3, we invoke the instance method `choices`.

On lines 6 to 8 we define the `choices` instance method. Its only expression is an array literal `["eat a nice lunch", "take a nap soon", "stay at work late"]`. Since this is the last expression of the method, this array is returned by the `choices` instance method.

Back on line 4, we take the array returned by `choices` and call the method `sample` on it. `sample` picks a random element from the array and returns it. It could be any of the three elements. We then prepend that element, which is a string, with the string `"You will "` using string concatenation. Since this is the last expression of the `predict_the_future` method, this is its return value.

Thus, we get 3 possible return values.
