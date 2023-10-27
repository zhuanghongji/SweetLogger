# SweetLogger 

A beautiful and sweet logger for SwiftUI. 🐝

## Install

```
https://github.com/zhuanghongji/SweetLogger
```

- Copy the URL of the repository provided above.
- Paste it into the text field located at the top-right corner of the window by navigating to "File" -> "Add Package Dependencies...".
- Click on "Add Package".

## Basic usage

You can enable Sweet Logger anytime and anywhere you want, for example:

```swift
@main
struct ExampleApp: App {

    init() {
#if DEBUG
        Logger.options.enabled = true
#endif
    }

    // ...
}
```

**Note: Please ensure that Logger is enabled during debug, as it is disabled by default.**

### Level

```swift
Logger.v("Verbose mssage")
Logger.i("Info message")
Logger.d("Debug message")
Logger.w("Warning message")
Logger.e("Error message")
```

Prints:

```
⚪️ [V] 08:26:21.8080 Sweet Default : Verbose mssage

🟢 [I] 08:26:21.8090 Sweet Default : Info message

🔵 [D] 08:26:21.8090 Sweet Default : Debug message

🟠 [W] 08:26:21.8090 Sweet Default : Warning message

🔴 [E] 08:26:21.8090 Sweet Default : Error message
```

### With items

```swift 
Logger.v("With items", 1, 2, 3)
Logger.v("With items", "a", "b", "c")
Logger.v("With items(array)", [1, 2, 3])
Logger.v("With items(dictionary)", ["a": 1, "b": 2, "c": 3])
Logger.v("With items(empty string)", "")

let url = URL(string: "https://developer.apple.com")
Logger.v("The url is", url ?? "__nil__")

let point = CGPoint(x: 1, y: 2)
Logger.v("The point is", point)

let rect = CGRect(x: 1, y: 2, width: 3, height: 4)
Logger.v("The rect is", rect)
```

Prints:

```
⚪️ [V] 08:26:21.8090 Sweet Default : With items
1 2 3

⚪️ [V] 08:26:21.8100 Sweet Default : With items
a b c

⚪️ [V] 08:26:21.8100 Sweet Default : With items(array)
[1, 2, 3]

⚪️ [V] 08:26:21.8100 Sweet Default : With items(dictionary)
["a": 1, "b": 2, "c": 3]

⚪️ [V] 08:26:21.8100 Sweet Default : With items(empty string)
__EmptyString__

⚪️ [V] 08:26:21.8100 Sweet Default : The url is
https://developer.apple.com

⚪️ [V] 08:26:21.8100 Sweet Default : The point is
(1.0, 2.0)

⚪️ [V] 08:26:21.8110 Sweet Default : The rect is
(1.0, 2.0, 3.0, 4.0)
```

### Custom tag 

```swift
Logger.t("MyTag").v("Custom tag")
Logger.t("AnotherTag").v("Another tag with items", true, false, separator: ", ")
```

Prints: 

```
⚪️ [V] 08:26:21.8110 Sweet MyTag : Custom tag

⚪️ [V] 08:26:21.8110 Sweet AnotherTag : Another tag with items
true, false
```

## Advance usage

### With data 

```swift
class MyClass {
    var p1 = 1
    var p2 = "Two"
    var p3 = true
    var p4 = false
    var pEmptyString = ""
}

extension MyClass: CustomStringConvertible {
    var description: String {
        "MyClass(p1: \(p1), p2: \(p2), p3: \(p3), p3: \(p4), pEmptyString: \(pEmptyString))"
    }
}

extension MyClass: SweetLoggerDataProvider {
    func provideSweetLoggerData(data: SweetLoggerData) {
        data.type("MyClass")
            .with("p1", p1)
            .with("p2", p2)
            .with("p3", p3)
            .with("p4", p4)
            .with("pEmptyString", pEmptyString)
            .end()
    }
}

let myClass = MyClass()
Logger.v("When myClass with item", myClass)
Logger.v("When myClass with data", data: myClass)
```

Prints: 

```
⚪️ [V] 08:26:21.8110 Sweet Default : When myClass with item
MyClass(p1: 1, p2: Two, p3: true, p3: false, pEmptyString: )

⚪️ [V] 08:26:21.8120 Sweet Default : When myClass with data
MyClass {
    p1: 1
    p2: Two
    p3: true
    p4: false
    pEmptyString: __EmptyString__
}
```

### With optional data

```swift
var myClass: MyClass? = MyClass()
Logger.v("When myClass with optional", optional: myClass)

myClass = nil
Logger.v("When myClass is exactly nil", optional: myClass)
```

Prints: 

```
⚪️ [V] 08:26:21.8120 Sweet Default : When myClass with optional
MyClass {
    p1: 1
    p2: Two
    p3: true
    p4: false
    pEmptyString: __EmptyString__
}

⚪️ [V] 08:26:21.8120 Sweet Default : When myClass is exactly nil
__nil__
```

### With preseted data provider

```swift
let url = URL(string: "https://developer.apple.com/abc?v1=1")!
Logger.v("The url with data", data: url)

let point = CGPoint(x: 1, y: 2)
Logger.v("The point with data", data: point)

let rect = CGRect(x: 1, y: 2, width: 3, height: 4)
Logger.v("The rect with data", data: rect)
```

Prints: 

```
⚪️ [V] 08:26:21.8120 Sweet Default : The url with data
URL {
    absoluteString: https://developer.apple.com/abc?v1=1
    absoluteURL: https://developer.apple.com/abc?v1=1
    baseURL: __nil__
    fragment: __nil__
    host: developer.apple.com
    lastPathComponent: abc
    pathExtension: __EmptyString__
    port: __nil__
    query: v1=1
    scheme: https
}

⚪️ [V] 08:26:21.8120 Sweet Default : The point with data
CGPoint {
    x: 1.0
    y: 2.0
}

⚪️ [V] 08:26:21.8120 Sweet Default : The rect with data
CGRect {
    x: 1.0
    y: 2.0
    width: 3.0
    height: 4.0
    minX: 1.0
    minY: 2.0
    midX: 2.5
    midY: 4.0
    maxX: 4.0
    maxY: 6.0
}
```

## License

SweetLogger is available under the MIT license. See the LICENSE file for more info.