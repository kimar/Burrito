## Burrito

##### Type-Safe unwraps with default value.

Implicitly unwrap optional values and use default values whenever needed.

### Quickstart

Burrito helps you to get your 🌯 together and unwrap concisely and in a more readable fashion. 

Given you're about to instantiate the following struct:

```swift
struct Person {
	let name: String
}
```

With pure Swift you're likely to see this code in you App:

```swift
let person = Person(
	name: dict["name"] as? String ?? "Johnny Appleseed"
)
```

Using Burrito the required type will be inferredyou can make your code as readable as this:

```swift
let person = Person(
	name: dict.either("name") <~> "Johnny Appleseed"
)
```

What doesn't look like saving a lot of code at first clearly brings a few advantages:

1. No more maintaining the type you'd like to unwrap to, the type will automatically be inferred.
2. Easier to read code provides better maintainability
3. A closure can be provided to compute the default value:

```swift
let person = Person(
	name: dict.either("name") <~> {
		return computedName
	}
)
```

Please note that `<~>` is just syntactic sugar and can effortlessly be omitted.

Unwrapping dictionaries shouldn't be painful, let *Burrito* help you unwrap:

```swift
let json: [String: Any?] = [
	"name": Optional("Marcus"),
	"age": 31,
	"blog": URL(string: "https://blog.kida.io")!
]

let person = Person(
	name: json.unwrap("name") { "Unknown" }, // -> Marcus
	age: json.unwrap("age") { -1 }, // -> 31
	github: json.unwrap("github") {
		URL(string: "https://github.com/kimar")!
	} // -> https://github.com/kimar
)
```

As you can see, because `github` is non-existent in the payload, when trying to unwrap it a default value will be used. This value can be returned in the closure.


### Advanced Usage

By telling *Burrito* what type you'd like to unwrap and specify a default closure returning the value you'd expect if the object can't be unwrapped or casted:

**Trying to cast an `Int` to a `String` won't work e.g.:**

```swift
let value = Burrito<String>.unwrap(0) {
    return "This is not the String you're looking for!"
}

print(value) // -> "This is not the String you're looking for!"
```

**But when providing the correct type you'll get it's value back e.g.:**

```swift
let myString = "This is the String you're looking for…"
let value = Burrito<String>.unwrap(myString) {	return "This is not the String you're looking for!"
}

print(value) // -> "This is the String you're looking for…"
```
