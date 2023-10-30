//
//  SweetLoggerData.swift
//  Example
//
//  Created by zhuanghongji on 2023/10/24.
//

import CoreGraphics
import Foundation

typealias SweetLoggerItem = (String, Any, Any?)

public class SweetLoggerData {
    static let ignoreFlag = "__IgnoreFlag__"

    var name: String = ""
    var items: [SweetLoggerItem] = []
    let useDebugPrint: Bool

    init(useDebugPrint: Bool) {
        self.useDebugPrint = useDebugPrint
    }
}

extension SweetLoggerData {
    public func type(_ name: String) -> SweetLoggerData {
        self.name = name
        return self
    }

    public func with(_ key: String, _ value: Any) -> SweetLoggerData {
        self.items.append((key, value, nil))
        return self
    }

    public func with(_ key: String, optional: Any?) -> SweetLoggerData {
        self.items.append((key, Self.ignoreFlag, optional))
        return self
    }

    public func end() {
        // do nothing
    }
}

extension SweetLoggerData {
    public func typed(_ name: String) {
        self.name = name
    }

    public func append(_ key: String, _ value: Any) {
        self.items.append((key, value, nil))
    }

    public func append(_ key: String, optional: Any?) {
        self.items.append((key, Self.ignoreFlag, optional))
    }

    public func sortByKey() {
        self.items.sort(by: { $0.0 < $1.0 })
    }
}

public protocol SweetLoggerDataProvider {
    func provideSweetLoggerData(data: SweetLoggerData)
}
