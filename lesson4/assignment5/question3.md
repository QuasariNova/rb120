In the last question Alan showed Alyssa this code which keeps track of items for a shopping cart application:

```ruby
class InvoiceEntry
  attr_reader :quantity, :product_name

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    quantity = updated_count if updated_count >= 0
  end
end
```

Alyssa noticed that this will fail when `update_quantity` is called. Since `quantity` is an instance variable, it must be accessed with the `@quantity` notation when setting it. One way to fix this is to change attr_reader to attr_accessor and change `quantity` to `self.quantity`.

Is there anything wrong with fixing it this way?

---

The first thing that may be wrong is that this would allow the setter `quantity=` to be accessible outside of the `InvoiceEntry` class. The `update_quantity` instance method guards against bad input and seems the proper way to interface with objects of this class, so having a backdoor probably wouldn't be advisable. This is because the `attr_reader` call is public, while you want the setter method to be private. By changing the `attr_reader` call, you are making both getter and setter public.

The second thing is you may not want to ever change the instance variable `@product_name`. It seems like a set once kind of variable, thus it might not need a setter. If you just change `attr_reader` to `attr_accessor`, you will be creating a setter method for it as well.
