# SweetLogger 

A beautiful and sweet logger for SwiftUI.

## Install

```
https://github.com/zhuanghongji/SweetLogger
```

- Copy the repo url above.
- "File" -> "Add Pacakge Dependencies...", paste into the text field in top-right of the window.
- Add Package.

## Usage

Enable Sweet Logger as anytime or anywhere you want, for example:

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

You can update logger options anytime and anywhere.

Note: Make sure to enable Logger at least during debug, as it is disabled by default.

### Basic

```swift
Logger.v("Verbose mssage")
Logger.i("Info message")
Logger.d("Debug message")
Logger.w("Warning message")
Logger.e("Error message")
```

Prints:

```
⚪️ [V] 2023-10-25 13:23:59.7560 SweetLogger Default : Verbose mssage

🟢 [I] 2023-10-25 13:23:59.7670 SweetLogger Default : Info message

🔵 [D] 2023-10-25 13:23:59.7670 SweetLogger Default : Debug message

🟠 [W] 2023-10-25 13:23:59.7680 SweetLogger Default : Warning message

🔴 [E] 2023-10-25 13:23:59.7680 SweetLogger Default : Error message
```

### With items

```swift 
Logger.v("Message with items", 1, 2, 3)
Logger.v("Message with items", "a", "b", "c")
Logger.v("Message with items(array)", [1, 2, 3])
Logger.v("Message with items(dictionary)", ["a": 1, "b": 2, "c": 3])
```

Prints:

```
⚪️ [V] 2023-10-25 13:24:55.7000 SweetLogger Default : Message with items
1 2 3

⚪️ [V] 2023-10-25 13:24:55.7010 SweetLogger Default : Message with items
a b c

⚪️ [V] 2023-10-25 13:24:55.7010 SweetLogger Default : Message with items(array)
[1, 2, 3]

⚪️ [V] 2023-10-25 13:24:55.7020 SweetLogger Default : Message with items(dictionary)
["b": 2, "a": 1, "c": 3]
```

### Custom tag 

```swift
Logger.t("MyCustomTag")
    .v("Custom tag and items", "item0", "item1", "item2", separator: ", ")
```

Prints: 

```
⚪️ [V] 2023-10-25 13:27:49.7990 SweetLogger MyCustomTag : Custom tag and items
item0, item1, item2
```

## Advance usage

### With data 

```swift
struct MyData {
    var p1 = 1
    var p2 = "Two"
}

extension MyData: SweetLoggerDataProvider {
    func provideSweetLoggerData(data: SweetLoggerData) {
        data.type("MyData")
        data.append("p1", self.p1)
        data.append("p2", self.p2)
    }
}

let data = MyData()
Logger.v("Message with data", data: data)
```

Prints: 

```
⚪️ [V] 2023-10-25 13:26:05.4660 SweetLogger Default : Message with data
MyData {
  "p2" : "Two",
  "p1" : 1
}
```

### With optional data

```swift
let optionalData: MyData? = MyData()
Logger.v("Message with optional data(exist)", optional: optionalData)
Logger.v("Message with optional data(absent)", optional: nil)
```

Prints: 

```
⚪️ [V] 2023-10-25 13:26:41.3710 SweetLogger Default : Message with optional data(exist)
MyData {
  "p1" : 1,
  "p2" : "Two"
}

⚪️ [V] 2023-10-25 13:26:41.3720 SweetLogger Default : Message with optional data(absent)
__NilData__
```

## License

SweetLogger is available under the MIT license. See the LICENSE file for more info.