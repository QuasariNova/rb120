#### What is an object? [book](https://launchschool.com/books/oo_ruby/read/the_object_model#whatareobjects)

Objects encapsulate state and are created from classes. They are an instance of a class. Everything with a value, thus state, is an object in Ruby. Individual objects have diffent states, but can still be instances of the same class.

#### What is a class? ([book](https://launchschool.com/books/oo_ruby/read/the_object_model#classesdefineobjects))

Classes are the blueprint that objects follow. Classes define both the behaviors and attributes of its objects.

In ruby, we define a class using `class` and end the definition with the reserved word `end`. Class names must start with a capital letter. A sample class could be something like this:

```ruby
class Car
  def initialize
    @paint = red
  end
end
```

#### What is instantiation? [book](https://launchschool.com/books/oo_ruby/read/the_object_model#classesdefineobjects)

The workflow of creating a new object from a class is called instatiation. In ruby, we instantiate instances of a class(objects) via the class method `new`.
