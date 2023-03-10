## Classes and objects
### Classes ([Book](https://launchschool.com/books/oo_ruby/read/the_object_model#classesdefineobjects))
Classes are the blueprint of which objects are made from. They define the attributes and the behaviors of objects.

They are defined in Ruby by using the reserved word `class` followed by the name of the class in CamelCase. We use the reserved word `end` to finish the definition.

You can instantiate objects from classes uses the `.new` class method. We can call the instance method `.class` to determine which class an object was instantiated from.

An example follows:

```ruby
class Person
  def initialize(name)
    @name = name
  end

  def laugh
    puts "#{@name} laughs"
  end
end

sally = Person.new "Sally"
bob = Person.new "Bob"
sally.laugh #=> Sally laughs
bob.laugh #=> Bob laughs
puts bob.class #=> Person
```

In the example above, we have a class definition for `Person` and we instantiate two objects of the `Person` type using the `.new` class method called from the `Person` class and assign them both to the local variables `sally` and `bob` respectively.

Classes define behavior for objects, so both `sally` and `bob` being instantiated from the same class can call the instance method `laugh`.

### Objects ([Book 1](https://launchschool.com/books/oo_ruby/read/the_object_model#whatareobjects)) ([Book 2](https://launchschool.com/books/oo_ruby/read/classes_and_objects_part1#statesandbehaviors))

Objects are created from classes and encapsulate state. What I mean by that is that each object is really just the data it holds in instance variables in regard to the class it was instantiated from. Instance variables, being scoped at the object level, are made available to instance methods called on the specific object they are tied to.

```ruby
class Person
  def initialize(name)
    @name = name
  end
end

sally = Person.new "Sally"
bob = Person.new "Bob"
p sally # => #<Person:0x0000000000fd3bf8 @name="Sally">
p sally.instance_variables # => [:@name]
p bob # => #<Person:0x0000000000cc9cf0 @name="Bob">
```

In the above example, we create two objects of the `Person` types by calling `.new` on the `Person` class. We use the `p` method to print their object and find that they both are `Person` objects with different object ids and each one has an instance variable named `@name` with `sally` having `"Sally"` as its value and `bob` having `"Bob"` as its value.

## How to call setters and getters
### Accessors ([Book](https://launchschool.com/books/oo_ruby/read/classes_and_objects_part1#accessormethods))

Accessor Methods are instance methods that interact with instance variables that allow you to set or get the data contained within the state of an object.

### setters ([Book](https://launchschool.com/books/oo_ruby/read/classes_and_objects_part1#accessormethods))
Setters are accessor methods defined inside a class that are coded to set an instance variable for an object. They are methods that name ends in an `=`, though by convention the instance variables name would prepend that `=`. So a setter for the instance variable `@name` would be called `name=`. Thanks to Ruby's syntactical sugar, we are able to call this method with a space like our other assignment methods.

Setter methods always return the object that was passed to them, regardless of what you actually set the instance variable it is setting to. You can call a setter method inside an instance method using `self.` prepended to the method name. If you do not use `self.` in this case, Ruby will initialize a local variable instead.

You can also use the methods `attr_writer` and `attr_accessor` passing the instance variable name as a symbol to automatically create a setter for you.

```ruby
class Person
  def initilaize(name)
    @name = name
  end

  def name=(value) # this is a setter method
    @name = value
  end

  def name
    @name
  end
end

bob = Person.new("Bob")
puts bob.name # => Bob
bob.name = "Bobby"
puts bob.name # => Bobby
```

In the above code we define the `Person` class that has three methods: the `initialize` method which is used as a constructor, the `name=` method that is used as a setter for the instance variable `@name` and the `name` method which acts as a getter for the `@name` instance variable. The `initialize` method takes one argument, which it uses to set the value of the `@name` instance variable. The `name=` method takes one argument, which use to set the `@name` instance variable as well.

In our code we initialize the local variable `bob` and set it to a new instance of the `Person` class passing `"Bob"` as an argument. We then use the getter instance method `name` on the `bob` object and pass its return value to the `puts` method outputing `Bob`. We then call the setter method `.name=` on the object referred to by `bob` using Rubys syntactical sugar and pass it the string `"Bobby"` as an argument. This sets `@name` inside the `bob` object to `"Bobby"`. We then output the return value of the `name` instance method called on the object stored in `bob` which is `Bobby`.

### getters ([Book](https://launchschool.com/books/oo_ruby/read/classes_and_objects_part1#accessormethods))

Getters are accessor methods defined inside a class that are used to access the values stored within the instance variables associated with an object.

```ruby
class Person
  def initilaize(name)
    @name = name
  end

  def name # This is a getter method for @name
    @name
  end
end

sally = Person.new "Sally"
puts sally.name # => Sally
```
In the code above, we define the `Person` class so that it will create objects that contain the instance variable `@name`. To access that instance variable outside of the class, we had to create a getter method `name` that returns the value associated with the instance variable `@name`. Without out, we could not know that the `Person` object referenced by the local variable `sally` had its instance variable `@name` set to `"Sally"`.

We can also quickly define getters by calling the `attr_reader` or `attr_accessor` methods inside the class as both automatically create a getter by using the symbol passed to them as an argument.

## Use attr_* to create setter and getter methods
### attr_reader ([docs](https://docs.ruby-lang.org/en/master/Module.html#method-i-attr_reader)) ([Book](https://launchschool.com/books/oo_ruby/read/classes_and_objects_part1#accessormethods))
`attr_reader` is used inside classes and module definitions to automatically create getter methods to instance variables you pass in as symbols.

```ruby
class Pencil
  attr_reader :lead_color
end

# is the same as
class Pencil
  def lead_color
    @lead_color
  end
end
```

In the code above, we define a `Pencil` class that calls the `attr_reader` method passing the symbol `:lead_color` as an argument inside the class definition. This causes Ruby to create the instance method `lead_color` that returns the object referred to by the instance variable `@lead_color`.

The second `Pencil` definition shows the manual way to define the `lead_color` method, which is functionally the same as the previous definition.

### attr_writer ([Docs](https://docs.ruby-lang.org/en/master/Module.html#method-i-attr_writer)) ([Book](https://launchschool.com/books/oo_ruby/read/classes_and_objects_part1#accessormethods))
`attr_writer` is called inside class and module definitions to automatically create setter methods for instance variables you pass as symbols.

```ruby
class Pencil
  attr_writer :lead_color
end

# is the same as
class Pencil
  def lead_color=(lead_color)
    @lead_color = lead_color
  end
end
```

In the code above, we define a `Pencil` class that calls the `attr_writer` method passing the symbol `:lead_color` as an argument inside the class definition. This will create a `lead_color=` instance method to be used as a setter for `@lead_color` for an object of `Pencil` type.

In the second `Pencil` definition, we do the same thing manually. Both class definitions are functionally the same.

### attr_accessor ([Docs](https://docs.ruby-lang.org/en/master/Module.html#method-i-attr_accessor) )([Book](https://launchschool.com/books/oo_ruby/read/classes_and_objects_part1#accessormethods))
`attr_accessor` is a method, that when called inside a class or module, will automatically create both getter and setter methods for instance variables you pass as symbols.

```ruby
class Pencil
  attr_accessor :lead_color
end

# is the same as
class Pencil
  def lead_color=(lead_color)
    @lead_color = lead_color
  end

  def lead_color
    @lead_color
  end
end
```

In the code above, we define a `Pencil` class that calls the `attr_accessor` method passing the symbol `:lead_color` as an argument inside the class definition. This will create both the setter method `lead_color=`, but also the getter method `lead_color` that set/get the instance variable `@lead_color` for an object of `Pencil` type.

The second `Pencil` definiton does the same thing, but manually. Both class definitions are functionally the same.

## Instance variables, class variables, and constants, including the scope of each type and how inheritance can affect that scope
### Instance Variables ([Book](https://launchschool.com/books/oo_ruby/read/classes_and_objects_part1#instancevariables)) ([Lesson 3](https://launchschool.com/lessons/d2f05460/assignments/b4f9e5b7))

Instance variables are variables that have an `@` prepended to their name. It is a variable that only exists with the object it was initialized in. Each object of a type will have its own separate instance variables and they are what makes up the objects state. Instance variables are scoped to the object that they were initialized in and are manipulated by instance methods called on the object. Instance variables can be used even if they are not initialized, which in that case they will return nil.

```ruby
class Person
  def initialize(name)
    @name = name
  end

  def to_s
    "My name is #{@name}"
  end
end

test = Person.new("Bob")
test2 = Person.new("Sally")
puts test
puts test2
```

In the above example we instantiate an object of type `Person` and assign it to a local variable named `test` by calling the class method `new` on it and passing the string `"Bob"` as an argument. `new` calls the constructor, which is the instance method `initialize` that has one parameter, which then assigns what was passed to the instance variable `@name`.

We also override the `to_s` instance method in the `Person` class to take the instance variable `@name` and use string interpolation to add it to a message. We then see that message when we pass our `Person` object referred to by `test` to the `puts` method.

We also do the same thing passing `"Sally"` and assigning the resulting object to the local variable `test2`. This shows that both `test` and `test2` are the same type, but have two different object references stored in their `@name` instance variable.

### Class Variables ([Book](https://launchschool.com/books/oo_ruby/read/classes_and_objects_part2#classvariables)) ([Lesson 3](https://launchschool.com/lessons/d2f05460/assignments/b4f9e5b7))

Class variables are scoped at the class level and start with `@@`. It is specific to the class and not the object, but you can use both class methods and instance methods to manipulate class variables. You have to be careful because class variables are shared with all subclassess of a superclass and have to be initialized in order to use them. They are usually initialized in the class definition.

```ruby
class Person
  @@people = 0

  def intialize
    @@people += 1
  end

  def self.people
    @@people
  end
end

puts Person.people # 0
Person.new
Person.new
puts Person.people # 2
```

The above code shows how to intialize a class variable. In it, we intialize the class variable `@@people` inside the `Person` class and assign it to the integer `0`. On line 222, we call the `puts` method outputing the return value of the `people` class method from the `Person` class. The `people` class method returns the value stored in `@@people`. `puts` outputs `0` since it has just been defined.

On lines 223 and 224, we inistantiate two instances of the `Person` class by calling the class method `new`. This will call the instance method `initialize`, which increments the class variable `@@people` by 1. Even though, these are two different objects, they both increase the same `@@people`. Which we see when we call `puts` on the return value of the class method `people` from the `Person` class. This time it outputs `2` showing that these two objects manipulated the same variable.

### Constants ([Book](https://launchschool.com/books/oo_ruby/read/classes_and_objects_part2#constants))([Lesson 3](https://launchschool.com/lessons/d2f05460/assignments/b4f9e5b7))

Constants are variables you never want to change and are defined by naming them starting with a capital letter, though Ruby style guildines suggest it is named with all capitals. Constants have lexical scope, which means that they first look for a constant by where it used in the code, then by inheritance, then finally looking at the top level.

When it searches lexically, it will check the class or module that tried to reference it first, then it would go out of it by namespace searching for the constant until it hits the top level. This is kind of like Russian nesting dolls.

```Ruby
module Greenable
  def is_green
    DECIDUOUS ? "Maybe" : "Yes"
  end
end

class Tree
  DECIDUOUS = true

  include Greenable

  def sheds_leaves?
    DECIDUOUS
  end
end

module Evergreen
  DECIDUOUS = false

  class Spruce < Tree
    def changes_color?
      DECIDUOUS
    end
  end
end

blue_spruce = Evergreen::Spruce.new
```

I have an example above to show how it works. We are going to call a few methods on the local variable `blue_spruce` and find out what is output to show how lexical scope works. First let's call `changes_color?` on it.

```ruby
p blue_spruce.changes_color? # => false
```

This method call returns `false`. This is because we first search lexically for a constant. Since the code to get the value of DECIDUOUS is inside the class `Spruce`, it first searchs the class `Spruce` and it finds no definition for the constant `DECIDUOUS`. It then goes the next level up, which is in this case the module `Evergreen`. `Evergreen` does define `DECIDUOUS`, so it returns that value, `false`. What if we use the `::` operator to check what `DECIDUOUS` is on the `Spruce` object?

```ruby
p blue_spruce.class::DECIDUOUS # => true
```

It returns `true`. Since we used the `::` operator, we are telling Ruby where to search, thus it doesn't search lexically at all. It instead looks at the inheritance chain trying to find the constant and that's it. So once it doesn't find `DECIDUOUS` inside `Spruce`, it searches its superclass `Tree` and finds it with the value `true`.

```ruby
p blue_spruce.sheds_leaves? # => true
```

When we call `sheds_leaves?` on the `Spruce` object we get `true`. This is because `sheds_leaves?` is inside the `Tree` class which is a superclass of `Spruce`. This is where Ruby will start its search for the constant `DECIDUOUS` because thats where in the code it is. `Tree` has a `DECIDUOUS` defined, so we return that value, true.

```ruby
p blue_spruce.is_green # => NameError
```

In the last case, we try to call `is_green` on the Spruce object. We try to retrieve the value of `DECIDUOUS` this time inside the `Greenable` module. It does not find it inside the module, so it needs to go a level up. The next level up is the top level, so it skips that. It then tries the inheritance chain, but will not find `DECIDUOUS`. Finally it tries the top level, which also does not initilaize `DECIDUOUS`, thus it can not find it and raises a `NameError`.

## Instance methods vs. class methods
### Instance methods [Book](https://launchschool.com/books/oo_ruby/read/classes_and_objects_part1#instancemethods)

Instance methods are the behaviours of the objects created from the class that defines them. They are available to all instances of that class. They are able to access the instance variables of the object they are called on as they are part of the objects scope.

```ruby
class Person
  def initialize(name)
    @name = name
  end

  def greet
    puts "Hi, I'm #{@name}"
  end
end

bob = Person.new("Bob")
sally = Person.new("Sally")
bob.greet  # => Hi, I'm Bob
sally.greet # => Hi, I'm Sally
```

As you can see above, we create two instances of the person class, each with a different name passed as an argument. This gives each instance it's own state. Once we call the instance method `greet` on both of them, we can see that we get different output despite calling the same method the same way. This is because instance methods can act on instance variables, which differ with different objects of the same type.

### Class Methods [Book](https://launchschool.com/books/oo_ruby/read/classes_and_objects_part2#classmethods)

Class methods are methods that are called directly on the class. They are different from instance methods in that they are called on the class and not on an instantiated object. They are defined by prepending `self.` to the method name or by prepending the class name to the method name like: `ClassName.method_name`. This is because `self` is shorthand for the class it resides in outside of class methods and instance methods.

```ruby
class Tree
  def self.material
    "Wood"
  end
end

puts Tree.material # => Wood
puts Tree.new.material # => NoMethodError
```

In the above example, we show that you can call the `material` class method on the `Tree` class itself, but we receive a `NoMethodError` calling it on an object of `Tree` type.

## Method Access Control
### Method Access Control [Book](https://launchschool.com/books/oo_ruby/read/inheritance#privateprotectedandpublic)


### public []()


### private []()


### protected []()



## Referencing and setting instance variables vs. using getters and setters
### Referencing and setting instance variables []()


### Using Getters and Setters []()



## Class inheritance, encapsulation, and polymorphism
### Class Inheritance []()


### Encapsulation []()


### Polymorphism []()


## Modules []()


## Method lookup path []()


## `self` []()


### Calling methods with `self` []()


### More about `self` []()


## Reading OO code []()


## Fake operators and equality
### Fake operators []()

### Equality []()
#### `#==`
#### `#equal?`
#### `#eql?`

## Working with collaborator objects []()


## Create a code spike []()
