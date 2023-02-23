1.How do we create an object in Ruby? Give an example of the creation of an object.

---

We need to first have a class defined that the object will be instantiated from. I assume this question wants me to create a class and show how we would instantiate an object:

```ruby
class Car # Classes are in CamelCase
end

volvo = Car.new # we instantiate with the new method.
```
---

2.What is a module? What is its purpose? How do we use them with our classes? Create a module for the class you created in exercise 1 and include it properly.

---

A module is a way to group reusable code in one place. Basically, you can use a module to share functionality between classes without having to write the code multiple times.

```ruby
module Horn
  def press_horn
    puts "Honk Honk!"
  end
end

class Car
  include Horn
end

volvo = Car.new
volvo.press_horn

```
