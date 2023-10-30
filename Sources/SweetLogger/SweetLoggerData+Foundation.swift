//
//  SweetLoggerData+Foundation.swift
//  SweetLogger
//
//  Created by zhuanghongji on 2023/10/26.
//

import Foundation

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
