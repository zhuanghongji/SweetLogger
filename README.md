# SweetLogger 

A beautiful and sweet logger for SwiftUI. 🐝

## Install

```
https://github.com/zhuanghongji/SweetLogger
```

- Copy the URL of the repository provided above.
- Paste it into the text field located at the top-right corner of the window by navigating to "File" -> "Add Package Dependencies...".
- Click on "Add Package".

## Init

You can enable Sweet Logger anytime and anywhere you want, for example:

```swift
@main
struct ExampleApp: App {

    init() {
#if DEBUG
        initLogger()
#endif
    }

    func initLogger() {
        Logger.options.enabled = true

        // Logger.options.brand = "Bee"
        
        // Logger.options.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSS"
        // Logger.options.separator = "|"
        // Logger.options.terminator = "\n--------------------\n\n"

        // Logger.options.useLevelSymbol = false
        // Logger.options.useLevelDescrition = false
        // Logger.options.useDebugPrint = false

        // SweetLogger.shared.tag = "Honey"
    }

    // ...
}
```

Note: Please ensure that Logger is enabled during debug, as it is disabled by default.

## Basic usage

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
⚪️ [V] 08:40:41.9400 Sweet Default : Verbose mssage

🟢 [I] 08:40:41.9410 Sweet Default : Info message

🔵 [D] 08:40:41.9410 Sweet Default : Debug message

🟠 [W] 08:40:41.9410 Sweet Default : Warning message

🔴 [E] 08:40:41.9410 Sweet Default : Error message
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
⚪️ [V] 08:40:41.9410 Sweet Default : With items
1 2 3

⚪️ [V] 08:40:41.9420 Sweet Default : With items
"a" "b" "c"

⚪️ [V] 08:40:41.9420 Sweet Default : With items(array)
[1, 2, 3]

⚪️ [V] 08:40:41.9420 Sweet Default : With items(dictionary)
["a": 1, "b": 2, "c": 3]

⚪️ [V] 08:40:41.9420 Sweet Default : With items(empty string)
""

⚪️ [V] 08:40:41.9420 Sweet Default : The url is
https://developer.apple.com

⚪️ [V] 08:40:41.9420 Sweet Default : The point is
(1.0, 2.0)

⚪️ [V] 08:40:41.9420 Sweet Default : The rect is
(1.0, 2.0, 3.0, 4.0)
```

### Custom tag 

```swift
Logger.t("MyTag").v("Custom tag")
Logger.t("AnotherTag").v("Another tag with items", true, false, separator: ", ")
```

Prints: 

```
⚪️ [V] 08:40:41.9420 Sweet MyTag : Custom tag

⚪️ [V] 08:40:41.9420 Sweet AnotherTag : Another tag with items
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
⚪️ [V] 08:40:41.9430 Sweet Default : When myClass with item
MyClass(p1: 1, p2: Two, p3: true, p3: false, pEmptyString: )

⚪️ [V] 08:40:41.9430 Sweet Default : When myClass with data
MyClass {
    p1: 1
    p2: "Two"
    p3: true
    p4: false
    pEmptyString: ""
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
⚪️ [V] 08:40:41.9430 Sweet Default : When myClass with optional
MyClass {
    p1: 1
    p2: "Two"
    p3: true
    p4: false
    pEmptyString: ""
}

⚪️ [V] 08:40:41.9430 Sweet Default : When myClass is exactly nil
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
⚪️ [V] 08:40:41.9430 Sweet Default : The url with data
URL {
    absoluteString: "https://developer.apple.com/abc?v1=1"
    absoluteURL: https://developer.apple.com/abc?v1=1
    baseURL: "__nil__"
    fragment: "__nil__"
    host: "developer.apple.com"
    lastPathComponent: "abc"
    pathExtension: ""
    port: "__nil__"
    query: "v1=1"
    scheme: "https"
}

⚪️ [V] 08:40:41.9430 Sweet Default : The point with data
CGPoint {
    x: 1.0
    y: 2.0
}

⚪️ [V] 08:40:41.9440 Sweet Default : The rect with data
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

### Using logger modifiers

#### loggerAppearance(name:)

A wrapper of `onAppear(perform:)` and `onDisappear(perform:)`, for example:

```swift
struct TestLoggerModifiersView1: View {
    @State private var visible = true

    var body: some View {
        VStack {
            if visible {
                Image(systemName: "globe")
                    .loggerAppearance(name: "GlobeImage")
            }
            Button {
                visible.toggle()
            } label: {
                Text("Toggle Visibility")
            }
        }
        .padding()
    }
}
```

When the view appears, prints:

```
⚪️ [V] 08:40:41.9440 Sweet Default : loggerAppearance
onAppear(name: "GlobeImage")
```

After a tap on "Toggle Visibility" button, it will print:

```
⚪️ [V] 08:43:29.1100 Sweet Default : loggerAppearance
onDisappear(name: "GlobeImage")
```

#### loggerChange(of:initial:name:)

A wrapper of `onChange(of:initial:_:)`, for example: 

```swift
struct TestLoggerModifiersView2: View {
    @State private var count = 0

    var countDescrition: String {
        "\(count)"
    }

    var body: some View {
        VStack {
            Text(countDescrition)
            Button {
                count += 1
            } label: {
                withAnimation {
                    Text("Add Count")
                }
            }
        }
        .padding()
        .loggerChange(of: countDescrition, initial: true, name: "countDescrition")
        .loggerChange(of: count, initial: true, name: "count")
        .loggerChange(of: count)
    }
}
```

When this view initially appears, it will print:

```
⚪️ [V] 08:40:41.9440 Sweet Default : loggerChange
onChange(name: "countDescrition", oldValue: "0", newValue: "0")

⚪️ [V] 08:40:41.9440 Sweet Default : loggerChange
onChange(name: "count", oldValue: 0, newValue: 0)
```

After a tap on "Add Count" button, it will print:

```
⚪️ [V] 08:43:30.0390 Sweet Default : loggerChange
onChange(oldValue: 0, newValue: 1)

⚪️ [V] 08:43:30.0400 Sweet Default : loggerChange
onChange(name: "count", oldValue: 0, newValue: 1)

⚪️ [V] 08:43:30.0400 Sweet Default : loggerChange
onChange(name: "countDescrition", oldValue: "0", newValue: "1")
```

## License

SweetLogger is available under the MIT license. See the LICENSE file for more info.