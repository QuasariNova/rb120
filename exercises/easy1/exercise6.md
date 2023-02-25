Consider the following class definition:

```ruby
class Flight
  attr_accessor :database_handle

  def initialize(flight_number)
    @database_handle = Database.init
    @flight_number = flight_number
  end
end
```

There is nothing technically incorrect about this class, but the definition may lead to problems in the future. How can this class be fixed to be resistant to future problems?

---

Remove the line invoking `attr_accessor`. The instance variable `@database_handle` seems important to the implementation, but may not be needed outside. By offering it and removing the Database functionality of the class, if a coder used the reference anywhere it will cause problems down the line. By not offering the interface, you remove the temptation of using it.
