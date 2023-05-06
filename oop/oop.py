class Animal:
    pass


class Dog(Animal):
    pass


class Owczarek(Dog):
    pass


class Cat(Animal):
    pass


print(issubclass(Cat, Animal))
print(issubclass(Dog, Animal))
print(issubclass(Animal, Animal))
print(issubclass(Dog, Owczarek))  # nie, no jest na ddwrót

dog = Dog()
print(isinstance(dog, Animal))
print(isinstance(dog, Dog))
print(isinstance(dog, Cat))
