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

What would happen if I called the methods like shown below?

```ruby
tv = Television.new
tv.manufacturer
tv.model

Television.manufacturer
Television.model
```

---

The line `tv.manufacturer` will raise a `NoMethodError` because we do not define an instance method named `manufacturer` inside the `Television` class. We do define a class method with that name, which can be told because it is prepended by `self.` on line 2 where it is defined.

The line `tv.model` will execute the instance method `model` defined on lines 6 to 8.

The line `Television.manufacturer` will execute the class method `manufacturer` defined on lines 2 through 4 of the `Television` class.

The line `Television.model` will raise a `NoMethodError` because we do not define a class method named `model` inside the `Television` class. We do define an instance method, which can be told because it is not prepended by `self.`
