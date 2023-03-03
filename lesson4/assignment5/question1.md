Ben asked Alyssa to code review the following code:

```ruby
class BankAccount
  attr_reader :balance

  def initialize(starting_balance)
    @balance = starting_balance
  end

  def positive_balance?
    balance >= 0
  end
end
```

Alyssa glanced over the code quickly and said - "It looks fine, except that you forgot to put the @ before balance when you refer to the balance instance variable in the body of the positive_balance? method."

"Not so fast", Ben replied. "What I'm doing here is valid - I'm not missing an @!"

Who is right, Ben or Alyssa, and why?

---

Ben is right. On line 2, Ben invokes the `attr_reader` method passing the symbol `:balance` as an argument. The `attr_reader` method uses that symbol to make a getter method with that symbols name. So, the method `balance` is created and it returns `@balance`. `positive_balance?` is calling that method.
