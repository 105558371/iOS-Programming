// Base slass: Animal
class Animal {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    // Enforcing implementation: If a subclass doesn't override this, it crashes with this error.
    func makeSound() -> String {
        fatalError("Subclasses must override makeSound()")
    }
}

// Subclass: Dog
class Dog: Animal {
    override func makeSound() -> String {
        return "Woof! Woof!"
    }
}

// Subclass: Cat
class Cat: Animal {
    override func makeSound() -> String {
        return "Meow...meow..."
    }
}
