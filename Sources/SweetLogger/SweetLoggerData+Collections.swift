//
//  SweetLoggerData+Collections.swift
//  SweetLogger
//
//  Created by zhuanghongji on 2023/10/30.
//

import Foundation

extension Array: SweetLoggerDataProvider {
    public func provideSweetLoggerData(data: SweetLoggerData) {
        data.typed("Array")
        self.enumerated().forEach { item in
            data.append("\(item.offset)", item.element)
        }
    }
}

extension Dictionary: SweetLoggerDataProvider where Key: Comparable {
    public func provideSweetLoggerData(data: SweetLoggerData) {
        data.typed("Dictionary")
        self.forEach { key, value in
            data.append("\(key)", value)
        }
        data.sortByKey()
    }
}

extension Set: SweetLoggerDataProvider {
    public func provideSweetLoggerData(data: SweetLoggerData) {
        data.typed("Set")
        self.enumerated().forEach { item in
            data.append("\(item.offset)", item.element)
        }
    }
}
