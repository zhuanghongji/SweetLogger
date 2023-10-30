//
//  ContentView.swift
//  Example
//
//  Created by zhuanghongji on 2023/10/24.
//

import CoreGraphics
import Foundation
import SweetLogger
import SwiftUI

struct ContentView: View {
    init() {
        setupOptions()
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("🐝")
                Text("Hello, SweetLogger")
                Text("-----")
                NavigationLink {
                    CollectionsTestView()
                } label: {
                    Text("CollectionsTestView")
                }
                NavigationLink {
                    NestedDataTestView()
                } label: {
                    Text("NestedDataTestView")
                }
                NavigationLink {
                    ModifiersTestView()
                } label: {
                    Text("ModifiersTestView")
                }
                NavigationLink {
                    LogTestView()
                } label: {
                    Text("LogTestView")
                }
            }
        }
        .font(.title)
        .onAppear {
            // Basic usage
            testLevel()
            testWithItems()
            testCustomTag()

            // Advance useage
            testWithData()
            testWithOptionalData()
            testWithPresetedDataProvider()
        }
    }
}

// MARK: Options

func setupOptions() {

    // You can update logger options anytime and anywhere.
    //
    // Note: Make sure to enable Logger at least during debug,
    //       as it is disabled by default.
    Logger.options.enabled = true

    // Logger.options.brand = "Bee"
    // Logger.options.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSS"
    // Logger.options.separator = "|"
    // Logger.options.terminator = "\n--------------------\n\n"
    // Logger.options.maxDataNestingLevels = 6

    // Logger.options.useLevelSymbol = false
    // Logger.options.useLevelDescription = false
    // Logger.options.useDebugPrint = false

    // SweetLogger.shared.tag = "Honey"
}

// MARK: Basic usage

func testLevel() {
    Logger.v("Verbose mssage")
    Logger.i("Info message")
    Logger.d("Debug message")
    Logger.w("Warning message")
    Logger.e("Error message")
}

func testWithItems() {
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
}

func testCustomTag() {
    Logger.t("MyTag").v("Custom tag")
    Logger.t("AnotherTag").v("Another tag with items", true, false, separator: ", ")
}

// MARK: Advance usage

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

func testWithData() {
    let myClass = MyClass()
    Logger.v("When myClass with item", myClass)
    Logger.v("When myClass with data", data: myClass)
}

func testWithOptionalData() {
    var myClass: MyClass? = MyClass()
    Logger.v("When myClass with optional", optional: myClass)

    myClass = nil
    Logger.v("When myClass is exactly nil", optional: myClass)
}

func testWithPresetedDataProvider() {
    let url = URL(string: "https://developer.apple.com/abc?v1=1")!
    Logger.v("The url with data", data: url)

    let point = CGPoint(x: 1, y: 2)
    Logger.v("The point with data", data: point)

    let rect = CGRect(x: 1, y: 2, width: 3, height: 4)
    Logger.v("The rect with data", data: rect)
}

#Preview {
    ContentView()
}
