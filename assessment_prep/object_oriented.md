# Object Oriented Programming
## OOP
### What is OOP and why is it important? ([book](https://launchschool.com/books/oo_ruby/read/the_object_model))
Object Oriented Programming is a paradigm where code is organized conceptually into objects. Procedural programming has an issue with interdependencies as a code base get larger and Object Oriented Programming was designed to combat that.

With Object Oriented Program we cleanly organize code within a series of objects, where each object is responsible for their own data. Objects then interact with each other building up the programs we write. We do that through encapsulation and polymorphism.

By encapsulating data within an object, we define the public interface for the data and provide some protection in only allowing for intentional manipulation of its data. Through polymorphism, we give our data the ability to be manipulated by common interfaces, oftentimes in different ways.

Using both, we are able to maintain code easier by keeping the code tied to their conceptual objects. This allows for cleaner code. Also, by doing so we are able to work on a higher level of abstraction. This can lead to more flexibility in thinking about how to solve problems.

### What is encapsulation? ([lesson2](https://launchschool.com/lessons/dfff5f6b/assignments/8c6b8604)) ([book](https://launchschool.com/books/oo_ruby/read/the_object_model))

Encapsulation is a form of data protection that makes it so that data cannot be changed without intent. It is done by hiding functionality so that outside code can not use that functionality.

In Ruby's case this is done by creating objects and exposing interfaces to interact with those objects. Each object is basically a black box with specific ways to interact with it(interfaces), but what it does in response to those interactions are obscured by the black box. We only know what it outputs.

#### How does encapsulation relate to the public interface of a class? ([lesson2](https://launchschool.com/lessons/dfff5f6b/assignments/8c6b8604)) ([book](https://launchschool.com/books/oo_ruby/read/the_object_model))

Encapsulation lets us hide functionality of the object, but we can not hide everything or it would not be useful. Thus we expose methods and properties that the users of the object need. Exposing these particular methods and properties is done through method access control. We call this the public interface of the class.

The point of encapsulation is that we get the results we expect from the public interface. Implementation details don't matter as long as the publich interface acts as it should.

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

### What is polymorphism? ([book](https://launchschool.com/books/oo_ruby/read/the_object_model)) ([lesson2](https://launchschool.com/lessons/dfff5f6b/assignments/8c6b8604))

Polymorphism is the ability of different objects to respond to a common interface. Basically, its when two or more object types have a method with the same name in its public interface. This allows us to not really care what object we are calling that method on. They may have different functionality or implementation, but they still share a common interface.

An example of polymorphism is that we can call the `+` method on numbers, strings, and arrays:

```ruby
1 + 2 # => 3
[1, 2] + [3, 4] #=> [1, 2, 3, 4]
'abc' + 'def' #=> 'abcdef'
```

While the `+` method is implemented differently for each object, it is available for use for each of these objects.

#### Explain two different ways to implement polymorphism.([Lesson 2](https://launchschool.com/lessons/dfff5f6b/assignments/8c6b8604))

We can implement polymorphism in two ways: inheritance and duck typing.

With inheritance we are having a class inherit the behaviors of another class or module. If we are inheriting a class, we call the class we are inheriting from a superclass and the class we are defining as inherting from the supercalss a subclass. This allows the subclass to call methods(behaviors) defined by the superclass. We can also use interface inheritance by mixing in modules, which gives a class access to the methods(behaviors) defined by a module.

An example of inheritance would be like this:
```ruby
module Runable
  def run
    puts "Runs"
  end
end

class Bird
  def sing
    puts "Tweet"
  end
end

class Roadrunner < Bird
  include Runable
end

class Cheetah
  include Runable
end
```

In this example, we define the `Roadrunner` class that inherits the `Bird` class as a superclass and uses interface inheritance by mixing in the `Runable` module. We also define the `Cheetah` class that uses interface inheritance by mixing in the `Runable` module. Due to this, both instances of the `Roadrunner` class and the `Bird` class can call the common instance method `sing`, but also instances of the `Roadrunner` class and the `Cheetah` class can invoke the `run` method as well.

The other way to implement polymorphism is by duck typing. Duck typing occurs when objects of unrelated types both respond with the same method name.

We typically use inheritance for objects that are related conceptually, while we would use Duck typing for objects that are not.

Say we have a `Spring` class that has a `prepare` method that tightens the spring, while we also have a `PineCar` class that also has a `prepare` method that places the pine car at the top of the track. Code could be something like this:

```ruby
class Spring
  def prepare
    # put tension on spring
  end
end

class PineCar
  def prepare
    # put on top of slope
  end
end

Spring.new.prepare
PineCar.new.prepare
```

Even though `Spring` and `PineCar` are not related and have different implementations of the `prepare` method, they still share a common interface in that they can call a method named `prepare`. If we were to pass either object to a method that would call `prepare`, we'd expect them both to work regardless of how they worked. When we have an instance like this, it is Duck Typing.
