//
//  SweetLoggerData+Foundation.swift
//  Example
//
//  Created by 庄宏基 on 2023/10/26.
//

import Foundation

extension URL: SweetLoggerDataProvider {
    public func provideSweetLoggerData(data: SweetLoggerData) {
        data.type("URL")
            .with("absoluteString", absoluteString)
            .with("absoluteURL", absoluteURL)
            .with("baseURL", baseURL)
            .with("fragment", fragment)
            .with("host", host)
            .with("lastPathComponent", lastPathComponent)
            .with("pathExtension", pathExtension)
            .with("port", port)
            .with("query", query)
            .with("scheme", scheme)
            .end()
    }
}
