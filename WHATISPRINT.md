# What is print

## Docs 

### print(_:separator:terminator:)

```swift
/// Writes the textual representations of the given items into the standard output.
func print(
    _ items: Any...,
    separator: String = " ",
    terminator: String = "\n"
)
```

**Parameters:**

- `items`: Zero or more items to print.
- `separator`: A string to print between each item. The default is a single space (" ").
- `terminator`: The string to print after all items have been printed. The default is a newline ("\n").

**Discussion:**

You can pass zero or more items to the `print(_:separator:terminator:)` function. The textual representation for each item is the same as that obtained by calling `String(item)`. The following example prints a string, a closed range of integers, and a group of floating-point values to standard output:

```swift
print("One two three four five")
// Prints "One two three four five"

print(1...5)
// Prints "1...5"

print(1.0, 2.0, 3.0, 4.0, 5.0)
// Prints "1.0 2.0 3.0 4.0 5.0"
```

To print the items separated by something other than a space, pass a string as separator.

```swift
print(1.0, 2.0, 3.0, 4.0, 5.0, separator: " ... ")
// Prints "1.0 ... 2.0 ... 3.0 ... 4.0 ... 5.0"
```

The output from each call to `print(_:separator:terminator:)` includes a newline by default. To print the items without a trailing newline, pass an empty string as terminator.

```swift
for n in 1...5 {
    print(n, terminator: "")
}
// Prints "12345"
```

### debugPrint(_:separator:terminator:)

```swift
/// Writes the textual representations of the given items most suitable for debugging into the standard output.
func debugPrint(
    _ items: Any...,
    separator: String = " ",
    terminator: String = "\n"
)
```

**Parameters:**

It's exactly the same as `print(_:separator:terminator:)`.

**Discussion:**

The biggest difference with `print(_:separator:terminator:)` as follows:

- In `debugPrint`, the textual representations of the given items is most suitable for debugging.
- In `debugPrint`, the textual representation for each item is obtained by calling `String(reflecting: item)`, not like in `print` which is obtained by calling `String(item)`.

```swift
debugPrint("One two three four five")
// Prints "One two three four five"

debugPrint(1...5)
// Prints "ClosedRange(1...5)"

debugPrint(1.0, 2.0, 3.0, 4.0, 5.0)
// Prints "1.0 2.0 3.0 4.0 5.0"

debugPrint(1.0, 2.0, 3.0, 4.0, 5.0, separator: " ... ")
// Prints "1.0 ... 2.0 ... 3.0 ... 4.0 ... 5.0"

for n in 1...5 {
    debugPrint(n, terminator: "")
}
// Prints "12345"
```

### Differences

#### String

```swift
let value = "abc"

print(value)
// Prints "abc"

debugPrint(value)
// Prints ""abc"" (Wrapped with double quotes)
```

<!-- ### Optional

```swift
let optionalName: String? = "Ed Sheeran"
let optionalAge: Int? = 11

print(optionalName)
// Prints "abc"

debugPrint(optionalName)
// Prints ""abc""

let optionalName: String? = "Ed Sheeran"
let optionalAge: Int? = 11

print(optionalName, "began writing songs around the age of",  optionalAge, ".")

debugPrint(optionalName, "began writing songs around the age of",  optionalAge, ".")
he began writing songs around the age of eleven.
``` -->


#### Range

```swift
let value = 1..<5

print(value)
// Prints "1..<5"

debugPrint(value)
// Prints "Range(1..<5)"
```

#### ClosedRange

```swift
let value = 1...5

print(value)
// Prints "1...5"

debugPrint(value)
// Prints "ClosedRange(1...5)"
```

#### Custom Struct

```swift
struct MyStruct {
    var p1 = 1
    var p2 = 2
}
```

```swift
let value = MyStruct()

print(value)
// Prints "MyStruct(p1: 1, p2: 2)"

debugPrint(value)
// Prints "TheProjectName.MyStruct(p1: 1, p2: 2)"
```

#### Convertible 

```swift
class MyClass {
    var p1 = 1
    var p2 = 2
}

extension MyClass: CustomStringConvertible {
    var description: String {
        "MyClass(p1: \(p1), p2: \(p2))"
    }
}

extension MyClass: CustomDebugStringConvertible {
    var debugDescription: String {
        "DebugMyClass(p1: \(p1), p2: \(p2))"
    }
}
```

```swift
let value = MyClass()

print(value)
// Prints "MyClass(p1: 1, p2: 2)"

debugPrint(value)
// Prints "DebugMyClass(p1: 1, p2: 2)"
```

## Ability Test

### Print type defined in frameworks

```swift
let point = CGPoint(x: 1, y: 2)
print(point)
// Prints "(1.0, 2.0)"

let rect = CGRect(x: 1, y: 2, width: 3, height: 4)
print(rect)
// Prints "(1.0, 2.0, 3.0, 4.0)"
```

In the output of `(1.0, 2.0)` from `print(point)`, maybe it is easy to guess the first of tuple is `point.x` and the second one is `point.y`. But in the output of `(1.0, 2.0, 3.0, 4.0)` from `print(rect)`, it is hard to guess which one is `rect.x`, `rect.y`, `rect.width` or `rect.height`.

### Print class which is not string convertible

```swift
class SimpleClass {
    var p1 = 1
    var p2 = 2
}
```

```swift
let simpleClass = SimpleClass()
print(simpleClass)
// Example.SimpleClass

debugPrint(simpleClass)
// Example.SimpleClass
```

We can not get more detail infomation in a simple class, unless you conform it to `CustomStringConvertible` or `CustomDebugStringConvertible` just like the `MyClass` in sample above.

Attentionally, if you do not need different output between `print` with `debugPrint`, just conform only one of `CustomStringConvertible` and `CustomDebugStringConvertible`. Then, it works for both of print function:

```swift
extension SimpleClass: CustomStringConvertible {
    var description: String {
        "SimpleClass(p1: \(p1), p2: \(p2))"
    }
}

let simpleClass = SimpleClass()

print(simpleClass)
// Prints "SimpleClass(p1: 1, p2: 2)"

debugPrint(simpleClass)
// Prints "SimpleClass(p1: 1, p2: 2)"
```

### Print optional

```swift
let int: Int? = 123
print(int)
debugPrint(int)
// Same prints "Optional(123)"

let str: String? = "abc"
print(str)
debugPrint(str)
// Same prints "Optional("abc")"

let point: CGPoint? = CGPoint(x: 1, y: 2)
print(point)
debugPrint(point)
// Same prints "Optional((1.0, 2.0))"

let rect: CGRect? = CGRect(x: 1, y: 2, width: 3, height: 4)
print(rect)
debugPrint(rect)
// Same prints "Optional((1.0, 2.0, 3.0, 4.0))"

let simpleClass: SimpleClass? = SimpleClass()
print(simpleClass)
debugPrint(simpleClass)
// Same prints "Optional(SimpleClass(p1: 1, p2: 2))"
```

As mentioned above, there is always an "Optional" prefix in the output text, regardless of whether you use `print` or `debugPrint`.


### Print nil

```swift
let nilInt: Int? = nil
print(nilInt)
debugPrint(nilInt)
// Same prints "nil"

let nilString: String? = nil
print(nilString)
debugPrint(nilString)
// Same prints "nil"

let nilBool: Bool? = nil
print(nilBool)
debugPrint(nilBool)
// Same prints "nil"
```

You read that right, there is no "Optional" prefix in the output text, since it must be optional if the output is "nil".