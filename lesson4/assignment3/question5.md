There are a number of variables listed below. What are the different types and how do you know which is which?

```ruby
excited_dog = "excited dog"
@excited_dog = "excited dog"
@@excited_dog = "excited dog"
```

On line 1 we are dealing with a local variable. You can tell `excited_dog` is a local variable because it is all lowercase. We know its not a setter method as it is not prepended by `self.`

On line 2 we are dealing with an instance variable. You can tell `@excited_dog` is an instance variable because it is prepended by one `@`.

On line 3 we are dealing with a class variable. You can tell `@@excited_dog` is a class variable because it is prepended by `@@`.
