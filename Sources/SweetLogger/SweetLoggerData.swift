//
//  SweetLoggerData.swift
//  Example
//
//  Created by 庄宏基 on 2023/10/24.
//

import Foundation
import CoreGraphics

typealias SweetLoggerPair = (String, Any)

public class SweetLoggerData {
    let useDebugPrint: Bool
    
    init(useDebugPrint: Bool) {
        self.useDebugPrint = useDebugPrint
    }
    
    private var name: String = ""
    private var data: [SweetLoggerPair] = []
    
    var content: String {
        var content = name
        content.append(" {")
        data.forEach { (key, value) in
            let it = useDebugPrint ? String(reflecting: value) : String(describing: value)
            let _value = it.isEmpty ? "__EmptyString__" : it
            content.append("\n    \(key): \(_value)")
        }
        content.append(data.isEmpty ? "}" : "\n}")
        return content
    }
    
    public func type(_ name: String) -> SweetLoggerData {
        self.name = name
        return self
    }

    public func with(_ key: String, _ value: Any?) -> SweetLoggerData {
        data.append((key, value ?? "__nil__"))
        return self
    }
    
    public func end() {
        // do nothing
    }
}

public protocol SweetLoggerDataProvider {
    func provideSweetLoggerData(data: SweetLoggerData)
}


