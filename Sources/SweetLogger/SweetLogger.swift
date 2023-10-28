// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

public class SweetLogger {
    public static var options = SweetLoggerOptions()
    
    public static var shared = SweetLogger(tag: "Default")
    
    private let tag: String
    
    public init(tag: String) {
        self.tag = tag
    }
    
    var dateDescrition: String {
        let dateFormat = SweetLogger.options.dateFormat
        if dateFormat.isEmpty {
            return ""
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = SweetLogger.options.dateFormat
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
        guard SweetLogger.options.enabled else {
            return
        }
        var output = ""
        
        // context and message
        let mainChunks: [String] = [
            level.symbol,
            level.descrition,
            dateDescrition,
            SweetLogger.options.brand,
            tag,
            SweetLogger.options.separator,
            message.isEmpty ? "__EmptyMessage__" : message,
        ].filter {
            !$0.trimmingCharacters(in: .whitespaces).isEmpty
        }
        let mainContent = mainChunks.joined(separator: " ")
        output.append(mainContent)
        
        // items (newline first, then each item)
        if !items.isEmpty {
            let itemChunks: [String] = items.map { item in
                let it = SweetLogger.options.useDebugPrint ? String(reflecting: item) : String(describing: item)
                return it.isEmpty ? "__EmptyString__" : it
            }
            output.append("\n")
            output.append(itemChunks.joined(separator: separator))
        }
        
        // provider (newline first, then data provided)
        if provider == nil, optional {
            output.append("\n__nil__")
        } else if let provider {
            let data = SweetLoggerData()
            provider.provideSweetLoggerData(data: data)
            // Note: debugPrint not work with "\n"
            output.append("\n")
            output.append(data.content)
        }
        
        // raw
        if let raw {
            output.append("\n\(raw)")
        }
        
        // print with specified terminator
        output.append("\n")
        print(output, terminator: SweetLogger.options.terminator)
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
