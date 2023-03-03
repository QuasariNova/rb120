Alan created the following code to keep track of items for a shopping cart application he's writing:

```ruby
class InvoiceEntry
  attr_reader :quantity, :product_name

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    # prevent negative quantities from being set
    quantity = updated_count if updated_count >= 0
  end
end
```

Alyssa looked at the code and spotted a mistake. "This will fail when update_quantity is called", she says.

Can you spot the mistake and how to address it?

---

The mistake is this line:
```ruby
quantity = updated_count if updated_count >= 0
```

The intent seems to reassign `@quantity` if `update_count` is greater than equal to 0. However, in this case it is initializing a local variable `quantity` instead.

The quick fix would be to use `@quantity` instead of `quantity`. The better fix would be to create a setter method, either by defining `quantity=` or invoking the `attr_writer` method passing the symbol `:quantity` as an argument and then unambiguously calling that setter method by changing the line to this:

```ruby
self.quantity = updated_count if updated_count >= 0
```

If you do not call the setter method with `self.` prepended, it will still initialize a local variable instead of doing what you intend.
