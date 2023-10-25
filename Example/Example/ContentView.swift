//
//  ContentView.swift
//  Example
//
//  Created by 庄宏基 on 2023/10/24.
//

import CoreGraphics
import SwiftUI

struct ContentView: View {
    
    init() {
#if DEBUG
        // You can update logger options anytime and anywhere.
        //
        // Note: Make sure to enable Logger at least during debug,
        //       as it is disabled by default.
        Logger.options.enabled = true
#endif
    }

    var body: some View {
        VStack {
            Text("🐝")
            Text("Hello, SweetLogger")
        }
        .padding()
        .onAppear {
            Logger.v("Verbose mssage")
            Logger.i("Info message")
            Logger.d("Debug message")
            Logger.w("Warning message")
            Logger.e("Error message")

            // With items
            Logger.v("Message with items", 1, 2, 3)
            Logger.v("Message with items", "a", "b", "c")
            Logger.v("Message with items(array)", [1, 2, 3])
            Logger.v("Message with items(dictionary)", ["a": 1, "b": 2, "c": 3])

            // With data
            let data = MyData()
            Logger.v("Message with data", data: data)

            // With optional data
            let optionalData: MyData? = MyData()
            Logger.v("Message with optional data(exist)", optional: optionalData)
            Logger.v("Message with optional data(absent)", optional: nil)

            // Custom tag with ...
            Logger.t("MyCustomTag")
                .v("Message with custom tag and items",
                   "item0", "item1", "item2", separator: ", ")
            Logger.t("MyCustomTag")
                .v("Message with custom tag and data", data: data)
            Logger.t("MyCustomTag")
                .v("Message with custom tag and optional data", optional: optionalData)
        }
    }
}

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

#Preview {
    ContentView()
}
