//
//  SweetLoggerData+Foundation.swift
//  Example
//
//  Created by zhuanghongji on 2023/10/26.
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

extension URL: SweetLoggerDataProvider {
    public func provideSweetLoggerData(data: SweetLoggerData) {
        data.type("URL")
            .with("absoluteString", absoluteString)
            .with("fragment", optional: fragment)
            .with("host", optional: host)
            .with("lastPathComponent", lastPathComponent)
            .with("pathExtension", pathExtension)
            .with("port", optional: port)
            .with("query", optional: query)
            .with("scheme", optional: scheme)
            .end()
    }
}
