Using the following code, determine the lookup path used when invoking cat1.color. Only list the classes and modules that Ruby will check when searching for the #color method.

```ruby
class Animal
end

class Cat < Animal
end

class Bird < Animal
end

cat1 = Cat.new
cat1.color
```

This time the lookup path will look like this:

```
Cat
Animal
Object
Kernel
BasicObject
```

Since the `color` method is not found in any of these classes and there are no modules or superclasses left to traverse, this will now raise a `NoMethodError`.
