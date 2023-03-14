# Practice Test 1
# Got from gcpinckert repo

---

1

```ruby
class Person
  attr_reader :name

  def set_name
    @name = 'Bob'
  end
end

bob = Person.new
p bob.name
```

_What is output and why? What does this demonstrate about instance variables that differentiates them from local variables?_

---

This outputs:
```
nil
```

This is because on line 17, we initialize local variable `bob` and assign it to a new instantiation of the `Person` class by calling `new` on the `Person` class. We define the `Person` class on lines 9 through 15 and it does not have an `initialize` method defined. `Person` has two methods, `name` which is a getter for the instance variable `@name` and was defined by calling `attr_reader` and passing `:name`, and `set_name`, which will initialize and set the instance variable `@name` to the string `'Bob'`.

When we call the instance method `name` on the object referenced by `bob` on line 18, we attempt to access the instance variable `@name`. Since we never called `set_name`, `@name` has not been initialized. Uninitialized instance variables return `nil`. So, we return `nil` and pass that to the `p` method which then outputs `nil`.

This shows that we can access unitialized instance variables unlike local variables, which would raise a `NameError`.

2

```ruby
module Swimmable
  def enable_swimming
    @can_swim = true
  end
end

class Dog
  include Swimmable

  def swim
    "swimming!" if @can_swim
  end
end

teddy = Dog.new
p teddy.swim
```

_What is output and why? What does this demonstrate about instance variables?_

This will output:
```
nil
```

We initialize local variable `teddy` and assign it to a new instance of the `Dog` class. The `Dog` class includes mixin module `Swimmable` and defines one instance method itself called `swim`.

`swim` will return `"swimming!"` if the instance variable `@can_swim` has a truthy value. Since `@can_swim` is not initialized in this example, it will return a value of `nil`, which is falsy. Since it is falsy, `swim` will return `nil` instead. When we call `swim` on the object stored in `teddy`, it returns nil and is passed to `p` as an argument, which will output `nil`.

This demonstrates that you can access uninitialized instance variables.

---

3

```ruby
module Describable
  def describe_shape
    "I am a #{self.class} and have #{SIDES} sides."
  end
end

class Shape
  include Describable

  def self.sides
    self::SIDES
  end

  def sides
    self.class::SIDES
  end
end

class Quadrilateral < Shape
  SIDES = 4
end

class Square < Quadrilateral; end

p Square.sides
p Square.new.sides
p Square.new.describe_shape
```

_What is output and why? What does this demonstrate about constant scope? What does `self` refer to in each of the 3 methods above?_

The output will be:
```
4
4
NameError
```

This is due to constants having lexical scope. `Square` is a subclass of `Quadrilateral`, which initializes the constant `SIDES` and assigns it to the integer `4`.

`Quadrilateral` is a subclass of `Shape`, which includes mixin module `Describable` and defines the class method `self.sides` and the instance method `sides`. We know that `self.sides` is class method because it is prepended with `self.` `self` in this case refers to the class itself.

On line 99 we use `p` to print the return value of calling the class method `Shape::sides` on the `Square` class. The class method `Shape::sides` returns the `SIDES` constant that is inside the class that called it. We know this because it is prepended by `self::`. `self` in this case is the calling class and the `::` operator is used to tell Ruby to search this class. It will search `Square`, which is the calling class, then search `Quadrilateral`. Because `Quadrilateral` initialized the constant `SIDES`, it returns its value, `4`.

On line 100, we use `p` to print the return value of calling the instance method `Shape#sides` on a newly instantiated object of type `Square`. The instance method `sides` returns the value of the `SIDES` constant found inside the `Square` class. This is because it is prepended with `self.class::`. `self` in this case is the calling object and the `class` method returns the object's class. Using the `::` operator tells Ruby to search this class. It again finds `SIDES` in `Square` superclass `Quadrilateral` and returns `4`.

On line 101, we try to invoke the instance method `describe_shape` on a new instance of `Square`. This instance method is defined in the `Describable` module and tries to reference the constant `SIDES`. Since we don't use the `::` operator, it searches lexically. First it will search the module `Describable` since it was called from there, which it will not find it. It would check the next level, but the next level is the top level, so it skips it for now. Then it would check the inheritance chain for the class/module it was referred to in. `Describable` does not inherit from anything, so it can't find `SIDES` there. Finally it checks the top level, which does not initialize a constant named `SIDES`. Since it can't find a constant named `SIDES`, it will raise a `NameError`.

---

4

```ruby
class AnimalClass
  attr_accessor :name, :animals

  def initialize(name)
    @name = name
    @animals = []
  end

  def <<(animal)
    animals << animal
  end

  def +(other_class)
    animals + other_class.animals
  end
end

class Animal
  attr_reader :name

  def initialize(name)
    @name = name
  end
end

mammals = AnimalClass.new('Mammals')
mammals << Animal.new('Human')
mammals << Animal.new('Dog')
mammals << Animal.new('Cat')

birds = AnimalClass.new('Birds')
birds << Animal.new('Eagle')
birds << Animal.new('Blue Jay')
birds << Animal.new('Penguin')

some_animal_classes = mammals + birds

p some_animal_classes
```

_What is output? Is this what we would expect when using `AnimalClass#+`? If not, how could we adjust the implementation of `AnimalClass#+` to be more in line with what we'd expect the method to return?_

The output would be:
```
[#<Animal:0x000000000220b028 @name="Human">, #<Animal:0x000000000220afb0 @name="Dog">, #<Animal:0x000000000220af60 @name="Cat">, #<Animal:0x000000000220ae70 @name="Eagle">, #<Animal:0x000000000220ae20 @name="Blue Jay">, #<Animal:0x000000000220ada8 @name="Penguin">]
```

This is because the `AnimalClass#+` method concatenates the array of `Animals` stored in the local variable `@animals` with the same on the other object. I'm unsure what was intended. This question sucks.

---

5

```ruby
class GoodDog
  attr_accessor :name, :height, :weight

  def initialize(n, h, w)
    @name = n
    @height = h
    @weight = w
  end

  def change_info(n, h, w)
    name = n
    height = h
    weight = w
  end

  def info
    "#{name} weighs #{weight} and is #{height} tall."
  end
end


sparky = GoodDog.new('Spartacus', '12 inches', '10 lbs')
sparky.change_info('Spartacus', '24 inches', '45 lbs')
puts sparky.info
# => Spartacus weighs 10 lbs and is 12 inches tall.
```

_We expect the code above to output `”Spartacus weighs 45 lbs and is 24 inches tall.”` Why does our `change_info` method not work as expected?_

The reason that `change_info` does not work is that we are innitializing instance variables instead of calling the setter methods tied to `@name`, `@height`, and `@weight`. We can fix this by changing `change_info` in one of two different ways:

```ruby
  def change_info(n, h, w)
    @name = n
    @height = h
    @weight = w
  end
```

or

```ruby
  def change_info(n, h, w)
    self.name = n
    self.height = h
    self.weight = w
  end
```

The second solution is preferable. To disambiguate from initializing local variables, we need to prepend our setter method names with `self.` to make sure ruby knows we want to call the method on the calling object.

---

6

```ruby
class Person
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def change_name
    name = name.upcase
  end
end

bob = Person.new('Bob')
p bob.name
bob.change_name
p bob.name
```

_In the code above, we hope to output `'BOB'` on `line 16`. Instead, we raise an error. Why? How could we adjust this code to output `'BOB'`?_

`change_name` is an instance method defined on line 238. It is intended to change the instance variable `@name` value to an all caps version of itself. Since we are attempting to the setter method on line 239, but did not prepend it with `self.`, ruby assumes we want to create a local variable named `name` and initializes it. When we then try to call `name` getter method, we instead find the local variable `name` has shadowed it. So, when we try to call `upcase` on the value returned by the instance method `name`, we are instead calling it on the newly initialized local variable `name`, which has a value `nil`. `nil` does not have a method named `upcase`, thus we get a `NoMethodError`.

We can fix this by changing `change_name` to this:
```ruby
  def change_name
    self.name = name.upcase
  end
```

By prepending `self.` to the setter call, we disambiguate from initiaizling a local variable.

---

7

```ruby
class Vehicle
  @@wheels = 4

  def self.wheels
    @@wheels
  end
end

p Vehicle.wheels

class Motorcycle < Vehicle
  @@wheels = 2
end

p Motorcycle.wheels
p Vehicle.wheels

class Car < Vehicle; end

p Vehicle.wheels
p Motorcycle.wheels
p Car.wheels
```

_What does the code above output, and why? What does this demonstrate about class variables, and why we should avoid using class variables when working with inheritance?_

This will ouptut:
```
4
2
2
2
2
2
```

This is because class variables are shared across all subclasses of a superclass.

On line 267, we define the class `Vehicle`, which initializes the class variable `@@wheels` and sets it to the integer `4` and defines a class method `Vehicle::wheels`, which will return whatever `@@wheels` refers to.

On line 275, we print the return value of a call to `Vehicle::wheels` on the `Vehicle` class, which since the only thing that has happened has been the definition of the `Vehicle` class means that `@@wheels` will still be `4`, thus will return `4`.

On line 277, we define the `Motorcycle` class, which is a subclass to `Vehicle`. It reassigns the `@@wheels` class variable to `2`.

On line 281 and 282, we use the `p` method to print the return value of calling the class method `Vehicle::wheels` on both the class `Motorcycle` and `Vehicle`. Since `@@wheels` was reassigned, both return `2`.

On line 284, we define another subclass of `Vehicle` called `Car`, it doesn't change `@@wheels`.

On lines 286, 287, and 288, we again use the `p` method to print the return value of the `Vehicle::wheels` class method on the `Vehicle`, `Motorcycle`, and `Car` classes. Since `@@wheels` is still `2`, it outputs `2` 3 more times.

---

8

```ruby
class Animal
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

class GoodDog < Animal
  def initialize(color)
    super
    @color = color
  end
end

bruno = GoodDog.new("brown")
p bruno
```

_What is output and why? What does this demonstrate about `super`?_

The output would be:

```
#<GoodDog:0x0000000000c98218 @name="brown", @color="brown">
```

This is because `super` will call the superclasses method of the same name and without any arguments passed and no explicit parenthesis, will pass arguments given to the subclasses method to the superclasses method.

On line 337, we intialize the local variable `bruno` and assign it to a new instance of the `GoodDog` class, which we pass the string `"brown"` as an argument to its constructor.

On line 330, we define the `GoodDog` class as a subclass to `Animal`. On line 331, we define the constructor, the `initialize` method, which takes one parameter. On line 332, we use the `super` keyword, this will pass the same argument passed to `GoodDog#initialize` to the superclass `Animal#initialize`, which is `"brown"`.

We define the `Animal` class on 322 and its `initialize` method on line 325. `Animal#initialize` takes one parameter and assigns it to the instance variable `@name`. So our `GoodDog` object will have `@name` assigned to the string `"brown"`.

Back in the `GoodDog#initialize` method, we now assign `@color` to the parameter `color`, which is that same string `"brown"`. Thus our `GoodDog` instance is constructed with two instance variables `@name` and `@color` both assigned to the same string `"brown"`. So, when we use `p` to print this object, we get the above output.

---

9

```ruby
class Animal
  def initialize
  end
end

class Bear < Animal
  def initialize(color)
    super
    @color = color
  end
end

bear = Bear.new("black")
```

_What is output and why? What does this demonstrate about `super`?_

This will raise an `ArgumentError`. This is because `super` without arguments and with no explicit parenthesis, will try to pass the arguments passed to the method calling it to the superclasses method of the same name.

In this case, we are attempting to instantiate a new `Bear` object on line 376, which will call `Bear#initialize`, which is defined on line 370. The `initialize` method for `Bear` takes one parameter. `Bear` is a subclass of `Animal`, so when we call `super` on line 371 we are trying to call `Animal#initialize`.

Since `Bear#initialize` has one parameter, we try to pass that parameter to `Animal#initialize` as an argument. `Animal` is defined on line 364, and its `initialize` method is defined on 365. `Animal#initialize` does not have any parameters, so an `ArgumentError` will be raised.



---

10

```ruby
module Walkable
  def walk
    "I'm walking."
  end
end

module Swimmable
  def swim
    "I'm swimming."
  end
end

module Climbable
  def climb
    "I'm climbing."
  end
end

module Danceable
  def dance
    "I'm dancing."
  end
end

class Animal
  include Walkable

  def speak
    "I'm an animal, and I speak!"
  end
end

module GoodAnimals
  include Climbable

  class GoodDog < Animal
    include Swimmable
    include Danceable
  end

  class GoodCat < Animal; end
end

good_dog = GoodAnimals::GoodDog.new
p good_dog.walk
```

_What is the method lookup path used when invoking `#walk` on `good_dog`?_

```
GoodDog
Danceable
Swimmable
Animal
Walkable
```

Ruby looksup method using the method lookup path. It will check the class the object was instantiated from first. Then it would check the mixin modules, starting with the last `include` call. Next it would check the superclass of the class the object was instantiated from, then the mixin, then the superclass, etc... It checks until it runs out of superclasses to check or it finds the method.

In this case, the `walk` instance method is defined in the `Walkable` module. `GoodAnimals::GoodDog` is a subclass of `Animal` and includes two mixins `Swimmable` and `Danceable`. Since it does not find `walk` in `GoodDog`, `Danceable`, or `Swimmable`, it will move on to the `Animal` class. The `Animal` class does not have a `walk` method, but it does mixin the `Walkable` module. So, after checking `Animal` it will find it in the `Walkable` module.

---

11

```ruby
class Animal
  def eat
    puts "I eat."
  end
end

class Fish < Animal
  def eat
    puts "I eat plankton."
  end
end

class Dog < Animal
  def eat
     puts "I eat kibble."
  end
end

def feed_animal(animal)
  animal.eat
end

array_of_animals = [Animal.new, Fish.new, Dog.new]
array_of_animals.each do |animal|
  feed_animal(animal)
end
```

_What is output and why? How does this code demonstrate polymorphism?_

The output will be:
```
I eat.
I eath plankton.
I eat kibble.
```

This is an example of polymorphism because objects of different types, `Animal`, `Fish`, and `Dog`, can all call an instance method `eat`. We are manipulating disparate data with a common interface in `eat`.

On line 489 we inittialize local variable `array_of_animals` and assign it to an array with new instances of `Animal`, `Fish`, and `Dog` types as elements.

On line 490, we use `each` to iterate over the array referenced by `array_of_animals`, passing each element as an argument to the method `feed_animal`. `feed_animal` is defined on line 485 and calls the instance method `eat` on the object passed to it. `Animal`, `Fish`, and `Dog` all define different `eat` instance methods, which each output a different message and return `nil`.


---

12

```ruby
class Person
  attr_accessor :name, :pets

  def initialize(name)
    @name = name
    @pets = []
  end
end

class Pet
  def jump
    puts "I'm jumping!"
  end
end

class Cat < Pet; end

class Bulldog < Pet; end

bob = Person.new("Robert")

kitty = Cat.new
bud = Bulldog.new

bob.pets << kitty
bob.pets << bud

bob.pets.jump
```

_We raise an error in the code above. Why? What do `kitty` and `bud` represent in relation to our `Person` object?_

We raise a `NoMethodError` because we attempt to call `jump` on an `Array` object, instead of on an object that comes from `Pet` or a subclass of `Pet`.

On line 535, we initialize local variable `bob` and assign it to a new instance of `Person` using the class method `new`, passing `"Robert"` as an argument. On line 516, we define the `Person` class. On line 519, we define the constructor, `initialize`, which has one parameter. `initialize` is called via the class method `new` and initializes instance variables `@name` and `@pets`. `@name` is assigned to the value passed as an argument to the `new` class method, so it is assigned to `"Robert"`, while `@pets` is assigned to a new array.

The person class calls `attr_accessor` and passes the symbols `:name` and `:pets`. This creates four methods `name`, `name=`, `pets`, and `pets=`, which are getters and setters for `@name` and `@pets`. On lines 537 and 538, we create new instances of the `Cat` and `Bulldog` class assigning it to newly initialized local variables `kitty` and `bud` respectively. On lines 540 and 541, we add those objects to the array referred to by `@pets` of the `Person` object referenced by `bob` by calling the `<<` method on the return value of `Person#name`.

On 543, we try to call `jump` on the array returned by the `Person#pets` method, which `Array` does not have a `jump` method, thus raises a `NoMethodError`. We can fix this by iterating over the array:

```ruby
bob.pets.each do |pet|
  pet.jump
end
```

In this example, the `kitty` and `bud` local variables hold `Cat` and `Bulldog` objects. Once we added it to the array referenced by `@pets` in the object referenced by `bob`, they became collaborator objects for the `Person` object.

---

13

```ruby
class Animal
  def initialize(name)
    @name = name
  end
end

class Dog < Animal
  def initialize(name); end

  def dog_name
    "bark! bark! #{@name} bark! bark!"
  end
end

teddy = Dog.new("Teddy")
puts teddy.dog_name
```

_What is output and why?_

The output is

```
bark! bark!  bark! bark!
```

This is because we never initialize the local variable `@name` before calling the `dog_name` instance method on our object of `Dog` type.

On line 583, we initialize local variable `teddy` and assign it to a new instantiation of the `Dog` class by calling the `new` class method and passing the string `"Teddy"` as an argument.

We defined the `Dog` class on line 575 as a subclass of the `Animal` class. Its constructor, the method `initialize` is defined on 576 and takes 1 parameter. The `initialize` method itself is empty and will do nothing when called. The `Dog` class also defines an instance method `dog_name`, which returns a string with the value referenced by `@name` interpolated in. When it is called on line 584, it returns `"bark! bark!  bark! bark!"` because `@name` was never initialized, thus will return a value of `nil`.

Since `Animal` initializes and sets the `@name` variable in it's `initialize` method, you can do one of two things to fix this behavior. You can either call `super` in `Dog#initialize` or you can delete `Dog#initialize`. Either way will call `Animal#initialize` passing `"Teddy"` to it as an argument assigning `@name` to `"Teddy"`. This would change the codes output to `bark! bark! Teddy bark! bark!`.

---

14

```ruby
class Person
  attr_reader :name

  def initialize(name)
    @name = name
  end
end

al = Person.new('Alexander')
alex = Person.new('Alexander')
p al == alex # => true
```

_In the code above, we want to compare whether the two objects have the same name. `Line 11` currently returns `false`. How could we return `true` on `line 11`?_

_Further, since `al.name == alex.name` returns `true`, does this mean the `String` objects referenced by `al` and `alex`'s `@name` instance variables are the same object? How could we prove our case?_

To get the code above to compare the `Person` objects `@name` value when you check for equality, you will have to override the `==` instance method. By default it checks if two objects are the same object, so it will retrun `false` like it does above. If you add the `==` method to the `Person` class like so:

```ruby
class Person
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def ==(other)
    name == other.name
  end
end
```

then the code on line 11 would return true.

`String` overrides `==` as well and does not tell you if two `String`s are the same object. This does not mean that both the `String` objects referenced by `al` and `alex`'s `@name` instance variables are the same object. In order to test if they are, you need to use the `equal?` instance method instead, which checks if two objects are the same.

```ruby
p al.name.equal?(alex.name) # => false
```

---

15

```ruby
class Person
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def to_s
    "My name is #{name.upcase!}."
  end
end

bob = Person.new('Bob')
puts bob.name
puts bob
puts bob.name
```

_What is output on `lines 14, 15, and 16` and why?_

The output would be
```
Bob
My name is BOB
BOB
```

This is because we call `upcase!`, which mutates the caller, inside the `to_s` instance method.

On line 666, we initialize a new local variable `bob` and assign it to a new instance of the `Person` class, for which we passed `'Bob'` as an argument to the constructor. The `Person` class calls `attr_reader` passing the symbol `:name`, which creates an instance method `name` that returns the value referenced by the instance variable `@name`. `Person`'s constructor, the instance method `initialize`, takes one parameter and initializes and sets the `@name` instance variable to that parameter.

So, when we call `puts` on the return of the getter method `name` called on the `Person` object referred to by `bob`, we output `Bob`.

On line 668, we pass `bob` as an argument to the `puts` method. `puts` calls `to_s` on the object it receives as an argument and outputs it. `Person` defines the `to_s` method on line 661. `to_s` calls `upcase!` on the value returned by the getter method `name`, which will permanently mutate the value referenced by `@name` to `BOB`. It then interpolates that value into a message and returns the string that is a result. `puts` would then output `My name is BOB`.

On line 669, since we call `puts` on the return of the getter method `name` called on the `Person` object referred to by `bob` again, we output `BOB`. Since it was mutated previously, it changed.

---

16

_Why is it generally safer to invoke a setter method (if available) vs. referencing the instance variable directly when trying to set an instance variable within the class? Give an example._

It is generally safer to invoke a setter method vs. referencing the instance variable directly inside a class because it makes your code more maintainable. The idea is that if you ever need to change the implementation of how your value is handled, you won't have to go to every instance you used the reference to set the variable and change it each time you make the change. By using the setter method, you are keeping your code DRY.

```ruby
class EmptyStringError < StandardError
end

class Person
  attr_reader :name

  def initialize(name)
    self.name = name
  end

  # more code that sets @name

  def name=(name)
    raise EmptyStringError if name.nil? || name.empty?
    @name = name
  end
end
```

In the above example, I defined an instance method `name=` that is a setter for the instance variable `@name`. In this case, I have created a guard to keep you from setting the `@name` variable to a `nil` or empty string. If i had more than one time where I had to set `@name`, I would be copying myself all over.

---

17

_Give an example of when it would make sense to manually write a custom getter method vs. using `attr_reader`._

It's best to write a custom getter method when there has to be processing done to the value you are getting prior to it being useful as a value.

A good example is to ensure that you don't get a nil if the instance variable hasn't been initialized yet.

```ruby
class Person
  def pets
    @pets = [] if pets.nil?
    @pets
  end
end
```

In the above example, I initialize the `@pets` instance variable if `@pets` is not initialized so that any code that calls the getter does not run into problems with it returning `nil`. If we decide to iterate over it, it will still work.

---

18

```ruby
class Shape
  @@sides = nil

  def self.sides
    @@sides
  end

  def sides
    @@sides
  end
end

class Triangle < Shape
  def initialize
    @@sides = 3
  end
end

class Quadrilateral < Shape
  def initialize
    @@sides = 4
  end
end
```

_What can executing `Triangle.sides` return? What can executing `Triangle.new.sides` return? What does this demonstrate about class variables?_

`Triangle.sides` will return `nil`, `3` or `4`. This is because class variables are shared amongst all the subclasses of a class. `@@sides` is initialized in `Shape`, which both `Triangle` and `Quadrilateral` are subclasses for. The `sides` class method is defined in the `Shape` class and returns the value referenced by `@@sides`. Both the `Traingle` and `Quadrilateral` classes reassign the class variable `@@sides` inside their constructor, so it could be either value or its initial value `nil`.

`Triangle.new.sides` will always return `3`. This is because `Triangles` constructor will always be called before we invoke the `sides` instance method. The `sides` instance method is defined in the `Shape` class and returns `@@sides` reference. Since `@@sides` was just assigned to `3`, it will return `3`.

This shows that class variables are shared amongst all subclasses, thus you have to be careful when using them as all subclasses can reassign them however they please.

---

19

_What is the `attr_accessor` method, and why wouldn’t we want to just add `attr_accessor` methods for every instance variable in our class? Give an example._

`attr_accessor` is a method that creates both a setter method and getter method for instance variables by passing the instance variables name as a symbol. We do not always want both getter and setters available for every variable. In one case, you might only ever set a variable during instantiation and never change it again:

```ruby
class Person
  attr_reader :birth_date

  def intialize(birth_date)
    @birth_date = birth_date
  end
end

me = Person.new "03/19/1985"
puts me.birth_date # => 03/19/1985
```

In the above example, the date of someones birth never changes, so you would not want to be able to change that value. You would still want to be able to retreive that value. This is why `attr_reader` makes more sense that `attr_accessor` in this case.

---

20

_What is the difference between states and behaviors?_

State is the data associated with an object, while behaviors are how you can interact with that data. In Ruby, objects encapsulate state, which is all the instance variables, while instance methods are the behaviors that act on the instance variables.

---
