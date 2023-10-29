//
//  LogView.swift
//  Example
//
//  Created by 庄宏基 on 2023/10/29.
//

import SwiftUI

struct LogView: View {
    init() {
        Log.initOptions()
    }

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

#Preview {
    LogView()
}
