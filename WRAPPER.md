# Wrapper

Create an enum named `Log` that uses `Logger` internally:

```swift
import SweetLogger

/// A simple wrapper of Logger in SweetLogger.
enum Log {
    static func initOptions() {
#if DEBUG
        Logger.options.enabled = true
#endif
    }
    
    static func t(_ tag: String) -> SweetLogger {
        SweetLogger(tag: tag)
    }
}

extension Log {
    static func v(_ message: String, _ items: Any..., separator: String = " ") {
        Logger.v(message, items, separator: separator)
    }
    
    static func i(_ message: String, _ items: Any..., separator: String = " ") {
        Logger.i(message, items, separator: separator)
    }
    
    static func d(_ message: String, _ items: Any..., separator: String = " ") {
        Logger.d(message, items, separator: separator)
    }
    
    static func w(_ message: String, _ items: Any..., separator: String = " ") {
        Logger.w(message, items, separator: separator)
    }
    
    static func e(_ message: String, _ items: Any..., separator: String = " ") {
        Logger.e(message, items, separator: separator)
    }
}

// MARK: With Data Provider

extension Log {
    static func v(_ message: String, data: LogDataProvider) {
        Logger.v(message, data: data)
    }
    
    static func i(_ message: String, data: LogDataProvider) {
        Logger.i(message, data: data)
    }
    
    static func d(_ message: String, data: LogDataProvider) {
        Logger.d(message, data: data)
    }
    
    static func w(_ message: String, data: LogDataProvider) {
        Logger.w(message, data: data)
    }
    
    static func e(_ message: String, data: LogDataProvider) {
        Logger.e(message, data: data)
    }
}

// MARK: With Data Provider (Optional)

extension Log {
    static func v(_ message: String, optional: SweetLoggerDataProvider?) {
        Logger.v(message, optional: optional)
    }
    
    static func i(_ message: String, optional: SweetLoggerDataProvider?) {
        Logger.i(message, optional: optional)
    }
    
    static func d(_ message: String, optional: SweetLoggerDataProvider?) {
        Logger.d(message, optional: optional)
    }
    
    static func w(_ message: String, optional: SweetLoggerDataProvider?) {
        Logger.w(message, optional: optional)
    }
    
    static func e(_ message: String, optional: SweetLoggerDataProvider?) {
        Logger.e(message, optional: optional)
    }
}

// MARK: With Raw

extension Log {
    static func raw(_ message: String, _ raw: Any) {
        Logger.raw(message, raw)
    }
}
```

Then, you can use it throughout your project:

```swift
// Call it when your app first launched.
// Log.initOptions()

struct LogView: View {
    var body: some View {
        Text("Hello, Log")
            .onAppear {
                // Basic usage
                logLevel()
                logWithItems()
                logCustomTag()

                // Advance useage
                logWithData()
                logWithOptionalData()
                logWithPresetedDataProvider()
            }
    }
}

// MARK: Basic usage

func logLevel() {
    Log.v("Verbose mssage")
    Log.i("Info message")
    Log.d("Debug message")
    Log.w("Warning message")
    Log.e("Error message")
}

func logWithItems() {
    Log.v("With items", 1, 2, 3)
    Log.v("With items", "a", "b", "c")
    Log.v("With items(array)", [1, 2, 3])
    Log.v("With items(dictionary)", ["a": 1, "b": 2, "c": 3])
    Log.v("With items(empty string)", "")

    let url = URL(string: "https://developer.apple.com")
    Log.v("The url is", url ?? "__nil__")

    let point = CGPoint(x: 1, y: 2)
    Log.v("The point is", point)

    let rect = CGRect(x: 1, y: 2, width: 3, height: 4)
    Log.v("The rect is", rect)
}

func logCustomTag() {
    Log.t("MyTag").v("Custom tag")
    Log.t("AnotherTag").v("Another tag with items", true, false, separator: ", ")
}

// MARK: Advance usage

func logWithData() {
    let myClass = MyClass()
    Log.v("When myClass with item", myClass)
    Log.v("When myClass with data", data: myClass)
}

func logWithOptionalData() {
    var myClass: MyClass? = MyClass()
    Log.v("When myClass with optional", optional: myClass)

    myClass = nil
    Log.v("When myClass is exactly nil", optional: myClass)
}

func logWithPresetedDataProvider() {
    let url = URL(string: "https://developer.apple.com/abc?v1=1")!
    Log.v("The url with data", data: url)

    let point = CGPoint(x: 1, y: 2)
    Log.v("The point with data", data: point)

    let rect = CGRect(x: 1, y: 2, width: 3, height: 4)
    Log.v("The rect with data", data: rect)
}
```

All outputs from `Log` are the same as those from `Logger`.