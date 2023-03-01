How do you find where Ruby will look for a method when that method is called? How can you find an object's ancestors?

```ruby
module Taste
  def flavor(flavor)
    puts "#{flavor}"
  end
end

class Orange
  include Taste
end

class HotSauce
  include Taste
end
```

What is the lookup chain for `Orange` and `HotSauce`?

`Orange` is:

`Orange` -> `Taste` -> `Object` -> `Kernel` -> `Basic Object`

`HotSauce` is:

`HotSauce` -> `Taste` -> `Object` -> `Kernel` -> `Basic Object`

You can always call `ancestors` on an object to find out its lookup chain.
