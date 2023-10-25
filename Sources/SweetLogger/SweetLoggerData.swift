//
//  SweetLoggerData.swift
//  Example
//
//  Created by 庄宏基 on 2023/10/24.
//

import Foundation
import CoreGraphics

public typealias SweetLoggerDictionary = [String: Any]

public class SweetLoggerData {
    private var name: String = ""
    private var data: SweetLoggerDictionary = [:]
    
    var dataContent: String {
        do {
            if data.keys.isEmpty {
                return "__EmptyData__"
            }
            let jsonData = try JSONSerialization.data(withJSONObject: data, options: [.prettyPrinted])
            let jsonContent = String(data: jsonData, encoding: .utf8)
            return jsonContent ?? "__FailedToSerializeData__"
        } catch {
            return "__ErrorWhenSerializingData__: \(error.localizedDescription)"
        }
    }
    
    var content: String {
        [name, dataContent].filter {
            !$0.trimmingCharacters(in: .whitespaces).isEmpty
        }.joined(separator: " ")
    }
    
    func type(_ name: String) {
        self.name = name
    }
    
    func append(_ key: String, _ value: Any) {
        data[key] = value
    }
}

public protocol SweetLoggerDataProvider {
    func provideSweetLoggerData(data: SweetLoggerData)
}


