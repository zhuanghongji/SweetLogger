//
//  NestedDataTestView.swift
//  Example
//
//  Created by zhuanghongji on 2023/10/30.
//

import SwiftUI
import SweetLogger

struct NestedDataTestView: View {
    init() {
        setupOptions()
    }
    
    var body: some View {
        Text("Nested Data Test View")
            .font(.title)
            .onAppear {
                testNested()
            }
    }
}


class NestedClass {
    let p1 = "1"
    let p2 = "Two"
    let p3: Bool? = false
    let pArray = ["a", "b", "c"]
    let pArrays = [
        ["a", "b", "c"],
        ["A", "B", "C"]
    ]
    let pDictionary: [String: String]
    let pDictionaries: [String: [String: String]]
    
    init() {
        let dict = [
            "a": "A",
            "b": "B",
            "c": "C"
        ]
        pDictionary = dict
        pDictionaries = [
            "a": dict,
            "b": dict,
            "c": dict
        ]
    }
}

extension NestedClass: SweetLoggerDataProvider {
    func provideSweetLoggerData(data: SweetLoggerData) {
        data.type("TestClass")
            .with("p1", p1)
            .with("p2", p2)
            .with("p3", optional: p3)
            .with("pArray", pArray)
            .with("pArrays", pArrays)
            .with("pDictionary", pDictionary)
            .with("pDictionaries", pDictionaries)
            .end()
    }
}

func testNested() {
    let nestedClass = NestedClass()
    Logger.d("With data(nested)", data: nestedClass)
}

#Preview {
    NestedDataTestView()
}
