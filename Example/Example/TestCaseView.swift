//
//  TestCaseView.swift
//  Example
//
//  Created by zhuanghongji on 2023/10/29.
//

import CoreGraphics
import SweetLogger
import SwiftUI

struct TestCaseView: View {
    init() {
        setupOptions()
    }

    var body: some View {
        Text("Some test case")
            .font(.title)
            .onAppear {
                testArray()
                testDictionary()
                testSet()
                testNested()
            }
    }
}

func testArray() {
    Logger.d("With data(array)", data: [1, 2, 3])
    Logger.d("With data(array)", data: ["a", "b", "c"])
    Logger.d("With data(array optional)", data: ["a", "b", "c", nil])
}

func testDictionary() {
    Logger.d("With data(dictionary)", data: ["a": 1, "b": 2, "c": 3])
    Logger.d("With data(dictionary optional)", data: ["a": 1, "b": 2, "c": 3, "d": nil])
}

func testSet() {
    let numbers: Set<Int> = [1, 2, 3]
    Logger.d("With data(set)", data: numbers)

    let strings: Set<String> = ["a", "b", "c"]
    Logger.d("With data(set)", data: strings)

    let dataSet: Set<HashableData> = [
        .init(x: 1, y: 2),
        .init(x: 3, y: 4),
        .init(x: 5, y: 6)
    ]
    Logger.d("With data(set)", data: dataSet)
}

struct HashableData: Hashable {
    let x: Int
    let y: Int
    
    static func == (lhs: HashableData, rhs: HashableData) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(x.hashValue)
        hasher.combine(y.hashValue)
    }
}

class TestClass {
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

extension TestClass: SweetLoggerDataProvider {
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
    let testClass = TestClass()
    Logger.d("With data(nested)", data: testClass)
}

#Preview {
    TestCaseView()
}
