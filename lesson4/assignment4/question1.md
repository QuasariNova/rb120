If we have this code:

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

What happens in each of the following cases:

---

case 1:

```ruby
hello = Hello.new
hello.hi
```

In this case, we instantiate a new object of the `Hello` class and then invoke the `hi` instance method on it. `hi` is defined in the `Hello` class on lines 8 to 10, so the method lookup chain finds it there without having to traverse any other locations.

Inside the `hi` method, we invoke the `greet` method passing it the string `"Hello"` as an argument. Ruby can not find the `greet` instance method inside the class `Hello` so it then checks the superclass of `Hello`. `Hello` is a subclass of `Greeting`, so it finds the `greet` instance method definition on lines 2-4. Since it found the method, the method invocation chain does not have to search elsewhere.

The `greet` method takes one parameter and then passes that value to the `puts` method as an argument. This outputs:

```
Hello
```

---

case 2:

```ruby
hello = Hello.new
hello.bye
```

In this case, we instantiate a new object of the `Hello` class and then try to invoke the `bye` instance method on it. `bye` is not defined inside the `Hello` class, so Ruby will move up the method invocation chain trying to find it.

Since the `bye` method is defined in the `Goodbye` class and the `Goodbye` class is not not inherited by the `Hello` class. Ruby will not find the method and raise a `NoMethodError`.

---

case 3:

```ruby
hello = Hello.new
hello.greet
```

We instantiate a new object of the `Hello` class and try to invoke the `greet` instance method on it. Since `Hello` is a subclass of `Greeting` where the `greet` is defined, Ruby will find it there.

The `greet` method has one paramater, but we are not passing any arguments to it. This will cause Ruby to raise an `ArgumentError`.

case 4:

```ruby
hello = Hello.new
hello.greet("Goodbye")
```

Similar to the previous one, we are invoking the `greet` method on an instance of the `Hello` class. Ruby would find `greet` inside the `Greeting` class, which is inherited by `Hello`.

We are now passing the string `"Goodbye"` to the instance method `greet`, which will output:

```
Goodbye
```

---

case 5:

```ruby
Hello.hi
```

In this case, we try to invoke a class method called `hi` from the class `Hello`. While `Hello` has an instance method named `hi`, it does not have a class method defined with that name. If it did, the name would be prepended by `self.` or `Hello.`

Ruby then checks its superclass `Greeting` and doesn't find it there. It will then check `Object`, `Kernel`, and `BasicObject` and still not find it. Since it did not find the method it will raise a `NoMethodError`.
