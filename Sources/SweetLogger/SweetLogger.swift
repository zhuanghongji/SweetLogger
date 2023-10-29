// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

public class SweetLogger {
    public static var options = SweetLoggerOptions()
    
    public static var shared = SweetLogger(tag: "Default")
    
    public var tag: String
    
    public init(tag: String) {
        self.tag = tag
    }
    
    func generateDateDescription(dateFormat: String) -> String {
        if dateFormat.isEmpty {
            return ""
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: Date())
    }
    
    func sweet(level: SweetLoggerLevel,
               message: String,
               items: [Any] = [],
               separator: String = " ",
               provider: SweetLoggerDataProvider? = nil,
               optional: Bool = false,
               raw: Any? = nil)
    {
        guard Self.options.enabled else {
            return
        }
        let brand = Self.options.brand
        let dateFormat = Self.options.dateFormat
        let _separator = Self.options.separator
        let terminator = Self.options.terminator
        let useLevelSymbol = Self.options.useLevelSymbol
        let useLevelDescription = Self.options.useLevelDescription
        let useDebugPrint = Self.options.useDebugPrint
        
        var output = ""
        
        // context and message
        let mainChunks: [String] = [
            useLevelSymbol ? level.symbol : "",
            useLevelDescription ? level.description : "",
            generateDateDescription(dateFormat: dateFormat),
            brand,
            tag,
            _separator,
            message.isEmpty ? "__EmptyMessage__" : message,
        ].filter {
            !$0.trimmingCharacters(in: .whitespaces).isEmpty
        }
        let mainContent = mainChunks.joined(separator: " ")
        output.append(mainContent)
        
        // items (newline first, then each item)
        if !items.isEmpty {
            let itemChunks: [String] = items.map { item in
                let it = useDebugPrint ? String(reflecting: item) : String(describing: item)
                return it.isEmpty ? "__EmptyString__" : it
            }
            output.append("\n")
            output.append(itemChunks.joined(separator: separator))
        }
        
        // provider (newline first, then data provided)
        if provider == nil, optional {
            output.append("\n__nil__")
        } else if let provider {
            let data = SweetLoggerData(useDebugPrint: useDebugPrint)
            provider.provideSweetLoggerData(data: data)
            output.append("\n")
            output.append(data.content)
        }
        
        // raw
        if let raw {
            output.append("\n\(raw)")
        }
        
        // print with specified terminator
        output.append("\n")
        print(output, terminator: terminator)
    }
}

// MARK: With Items

public extension SweetLogger {
    func v(_ message: String, _ items: Any..., separator: String = " ") {
        sweet(level: .verbose, message: message, items: items, separator: separator)
    }
    
    func i(_ message: String, _ items: Any..., separator: String = " ") {
        sweet(level: .info, message: message, items: items, separator: separator)
    }
    
    func d(_ message: String, _ items: Any..., separator: String = " ") {
        sweet(level: .debug, message: message, items: items, separator: separator)
    }
    
    func w(_ message: String, _ items: Any..., separator: String = " ") {
        sweet(level: .warning, message: message, items: items, separator: separator)
    }
    
    func e(_ message: String, _ items: Any..., separator: String = " ") {
        sweet(level: .error, message: message, items: items, separator: separator)
    }
}

// MARK: With Data Provider

public extension SweetLogger {
    func v(_ message: String, data provider: SweetLoggerDataProvider) {
        sweet(level: .verbose, message: message, provider: provider)
    }
    
    func i(_ message: String, data provider: SweetLoggerDataProvider) {
        sweet(level: .info, message: message, provider: provider)
    }
    
    func d(_ message: String, data provider: SweetLoggerDataProvider) {
        sweet(level: .debug, message: message, provider: provider)
    }
    
    func w(_ message: String, data provider: SweetLoggerDataProvider) {
        sweet(level: .warning, message: message, provider: provider)
    }
    
    func e(_ message: String, data provider: SweetLoggerDataProvider) {
        sweet(level: .error, message: message, provider: provider)
    }
}

// MARK: With Data Provider (Optional)

public extension SweetLogger {
    func v(_ message: String, optional provider: SweetLoggerDataProvider?) {
        sweet(level: .verbose, message: message, provider: provider, optional: true)
    }
    
    func i(_ message: String, optional provider: SweetLoggerDataProvider?) {
        sweet(level: .info, message: message, provider: provider, optional: true)
    }
    
    func d(_ message: String, optional provider: SweetLoggerDataProvider?) {
        sweet(level: .debug, message: message, provider: provider, optional: true)
    }
    
    func w(_ message: String, optional provider: SweetLoggerDataProvider?) {
        sweet(level: .warning, message: message, provider: provider, optional: true)
    }
    
    func e(_ message: String, optional provider: SweetLoggerDataProvider?) {
        sweet(level: .error, message: message, provider: provider, optional: true)
    }
}

// MARK: With Raw

public extension SweetLogger {
    func raw(_ message: String, _ raw: Any) {
        sweet(level: .verbose, message: message, raw: raw)
    }
}
