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

### setters ([Book](https://launchschool.com/books/oo_ruby/read/classes_and_objects_part1#accessormethods))
Setters are instance methods defined inside a class that are coded to set an instance variable for an object. They are methods that name ends in an `=`, though by convention the instance variables name would prepend that `=`. So a setter for the instance variable `@name` would be called `name=`. Thanks to Ruby's syntactical sugar, we are able to call this method with a space like our other assignment methods.

Setter methods always return the object that was passed to them, regardless of what you actually set the instance variable it is setting to. You can call a setter method inside an instance method using `self.` prepended to the method name. If you do not use `self.` in this case, Ruby will initialize a local variable instead.

You can also use the methods `attr_writer` and `attr_accessor` passing the instance variable name as a symbol to automatically create a setter for you.

```ruby
class Person
  def initilaize(name)
    @name = name
  end

  def name=(value)
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


## Use attr_* to create setter and getter methods
### attr_reader []()


### attr_writer []()


### attr_accessor []()


## Instance variables, class variables, and constants, including the scope of each type and how inheritance can affect that scope
### Instance Variables []()


### Class Variables []()


### Constants []()



## Instance methods vs. class methods
### Instance methods []()



### Class Methods []()



## Method Access Control
### Method Access Control []()


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
