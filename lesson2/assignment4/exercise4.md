What is the method lookup path and how is it important?

---

The method lookup path is used to find methods that are being invoked. It first checks the current class. If it doesn't find the method you are referencing in its class definition, it will then check each module that was mixed in. If it doesn't find the method there, it then checks the superclass for the current class. It continues to do this sequence until there is no superclass or it finds the method.

This is important for knowing what method you are actually calling. Modules and Classes can override each others methods and the method lookup path only picks one. Knowing how it works is important so that you know that behaviors are as intended.
