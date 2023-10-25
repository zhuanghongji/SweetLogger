//
//  SweetLoggerData+CoreGraphics.swift
//  Example
//
//  Created by 庄宏基 on 2023/10/24.
//

import CoreGraphics

extension CGRect: SweetLoggerDataProvider {
    public func provideSweetLoggerData(data: SweetLoggerData) {
        data.type("CGRect")
        data.append("origin.x", self.origin.x)
        data.append("origin.y", self.origin.y)
        data.append("size.width", self.size.width)
        data.append("size.height", self.size.height)
    }
}
