## Burrito

##### Type-Safe unwraps with fallback.

By telling `Burrito` what type you'd like to unwrap and specify a fallback closure returning the value you'd expect if the object can't be unwrapped or casted:

**Trying to cast an `Int` to a `String` won't work e.g.:**

```
let value = Burrito<String>.unwrap(0) {
    return "This is not the String you're looking for!"
}

print(value) // -> "This is not the String you're looking for!"
```

**But when providing the correct type you'll get it's value back e.g.:**

```
let myString = "This is the String you're looking for…"
let value = Burrito<String>.unwrap(myString) {
    return "This is not the String you're looking for!"
}

print(value) // -> "This is the String you're looking for…"
```

**This is expecially helpful when e.g. unwrapping values from JSON payloads (everybody loves JSON ❤️) Burrito even provides you with an Extension on Dictionary e.g.:**

```
let json: [String: Any?] = [
	"age": 31
]
let myObject = Object(
  name: json.unwrap("name") { "Unknown" } // -> "Unknown"
  age: json.unwrap("age") { -1 } // -> 31
)
```

