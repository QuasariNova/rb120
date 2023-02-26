What will the following code print?

```ruby
class Something
  def initialize
    @data = 'Hello'
  end

  def dupdata
    @data + @data
  end

  def self.dupdata
    'ByeBye'
  end
end

thing = Something.new
puts Something.dupdata
puts thing.dupdata
```

This code prints:

```
ByeBye
HelloHello
```

On line 18, we initialize local variable `thing` and assign it to a new instance of the `Something` class. On line 4, we define the class `Something`, to which we define its `initialize` method on line 5. Its `initialize` method initializes the `@data` instance variable and assigns it to the string `'hello'`.

On line 19, we call the class method `dupdata` on the class `Something`. This method is defined inside the `Something` class on line 13. We know that it is a class method because its name is prepended by `self.`. This method returns the string `'ByeBye'`, which will be passed to `puts` as an argument back on line 19, outputing `ByeBye`.

On line 20, we invoked the `dupdata` method on the `Something` object referenced by the local variable `thing`. We are invoking an instance method, and this method is defined on line 9 inside the `Something` class. This method concatenates the string referenced by the instance variable `@data` with itself and returns the results of that expression. Since `@data` points to the string `'Hello'`, this returns a new string with value `'HelloHello'`. So when this gets passed to the `puts` method as an argument back on line 20, it outputs `HelloHello`.
