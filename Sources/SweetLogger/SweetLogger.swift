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
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = SweetLogger.options.dateFormat
        return dateFormatter.string(from: Date())
    }
    
    func sweet(level: SweetLoggerLevel,
               message: String,
               items: [Any] = [],
               separator: String = " ",
               provider: SweetLoggerDataProvider? = nil,
               optional: Bool = false)
    {
        guard SweetLogger.options.enabled else {
            return
        }
        
        // message
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
        print(mainContent, terminator: "")
        
        // items (newline first, then each item)
        if !items.isEmpty {
            print("")
            let itemChunks: [String] = items.map { item in
                switch item {
                case let item as String:
                    if item.isEmpty {
                        return "__EmptyString__"
                    }
                default:
                    break
                }
                return SweetLogger.options.useDebugPrint ? String(reflecting: item) : String(describing: item)
            }
            print(itemChunks.joined(separator: separator), terminator: "")
        }
        
        // provider (newline first, then data provided)
        if provider == nil, optional {
            print("")
            print("__NilData__", terminator: "")
        } else if let provider {
            let data = SweetLoggerData()
            provider.provideSweetLoggerData(data: data)
            print("")
            // Just print, because debugPrint not work with "\n"
            print(data.content, terminator: "")
        }
        
        // final specified terminator
        print("\n", terminator: SweetLogger.options.divider)
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
