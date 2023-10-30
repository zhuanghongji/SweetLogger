//
//  SweetLoggerData+CoreGraphics.swift
//  SweetLogger
//
//  Created by zhuanghongji on 2023/10/24.
//

import CoreGraphics

extension CGPoint: SweetLoggerDataProvider {
    public func provideSweetLoggerData(data: SweetLoggerData) {
        data.type("CGPoint")
            .with("x", x)
            .with("y", y)
            .end()
    }
}

extension CGSize: SweetLoggerDataProvider {
    public func provideSweetLoggerData(data: SweetLoggerData) {
        data.type("CGSize")
            .with("width", width)
            .with("height", height)
            .end()
    }
}

extension CGRect: SweetLoggerDataProvider {
    public func provideSweetLoggerData(data: SweetLoggerData) {
        data.type("CGRect")
            .with("x", origin.x)
            .with("y", origin.y)
            .with("width", size.width)
            .with("height", size.height)
            .with("minX", minX)
            .with("minY", minY)
            .with("midX", midX)
            .with("midY", midY)
            .with("maxX", maxX)
            .with("maxY", maxY)
            .end()
    }
}

extension CGVector: SweetLoggerDataProvider {
    public func provideSweetLoggerData(data: SweetLoggerData) {
        data.type("CGVector")
            .with("dx", dx)
            .with("dy", dy)
            .end()
    }
}

extension CGAffineTransform: SweetLoggerDataProvider {
    public func provideSweetLoggerData(data: SweetLoggerData) {
        data.type("CGAffineTransform")
            .with("a", a)
            .with("b", b)
            .with("c", c)
            .with("d", d)
            .with("tx", tx)
            .with("ty", ty)
            .end()
    }
}

extension CGColor: SweetLoggerDataProvider {
    public func provideSweetLoggerData(data: SweetLoggerData) {
        data.type("CGColor")
            .with("components", components)
            .end()
    }
}
