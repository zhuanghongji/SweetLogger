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
    
    func append(output: inout String,
                provider: SweetLoggerDataProvider?,
                isProviderOptional: Bool,
                tab: Int,
                maxDataNestingLevels: Int,
                useDebugPrint: Bool)
    {
        output.append(tab == 0 ? "\n" : "")
        if isProviderOptional, provider == nil {
            output.append("nil")
            return
        }
        guard let provider else {
            return
        }
        let data = SweetLoggerData(useDebugPrint: useDebugPrint)
        provider.provideSweetLoggerData(data: data)
        
        // start
        output.append("\(data.name) {")
        
        // items
        var indent = ""
        for _ in 0 ..< tab {
            indent.append("    ")
        }
        data.items.forEach { key, value, optionalValue in
            output.append("\n\(indent)    \(key): ")
            var isValueOptional = false
            if let it = value as? String, it == SweetLoggerData.ignoreFlag {
                isValueOptional = true
            }
            // First, check if the `optionalValue` is actually nil.
            if isValueOptional, optionalValue == nil {
                output.append("nil")
                return
            }
                
            // Nested
            if tab <= maxDataNestingLevels {
                if let _provider = value as? SweetLoggerDataProvider {
                    append(output: &output,
                           provider: _provider,
                           isProviderOptional: false,
                           tab: tab + 1,
                           maxDataNestingLevels: maxDataNestingLevels,
                           useDebugPrint: useDebugPrint)
                    return
                }
                if isValueOptional, let _optionalProvider = optionalValue as? SweetLoggerDataProvider? {
                    append(output: &output,
                           provider: _optionalProvider,
                           isProviderOptional: true,
                           tab: tab + 1,
                           maxDataNestingLevels: maxDataNestingLevels,
                           useDebugPrint: useDebugPrint)
                    return
                }
            }
            
            // Not nested
            if isValueOptional {
                let str = useDebugPrint ? String(reflecting: optionalValue) : String(describing: optionalValue)
                output.append(str.isEmpty ? "__EmptyString__" : str)
                return
            }
            let str = useDebugPrint ? String(reflecting: value) : String(describing: value)
            output.append(str.isEmpty ? "__EmptyString__" : str)
        }
        
        // end
        output.append(data.items.isEmpty ? "" : "\n")
        output.append("\(indent)}")
    }
    
    func sweet(level: SweetLoggerLevel,
               message: String,
               items: [Any] = [],
               separator: String = " ",
               provider: SweetLoggerDataProvider? = nil,
               isProviderOptional: Bool = false,
               raw: Any? = nil)
    {
        guard Self.options.enabled else {
            return
        }
        let brand = Self.options.brand
        let dateFormat = Self.options.dateFormat
        let _separator = Self.options.separator
        let terminator = Self.options.terminator
        let maxDataNestingLevels = Self.options.maxDataNestingLevels
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
        
        // provider
        if provider != nil || isProviderOptional  {
            append(output: &output,
                   provider: provider,
                   isProviderOptional: isProviderOptional,
                   tab: 0,
                   maxDataNestingLevels: maxDataNestingLevels,
                   useDebugPrint: useDebugPrint)
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
        sweet(level: .verbose, message: message, provider: provider, isProviderOptional: true)
    }
    
    func i(_ message: String, optional provider: SweetLoggerDataProvider?) {
        sweet(level: .info, message: message, provider: provider, isProviderOptional: true)
    }
    
    func d(_ message: String, optional provider: SweetLoggerDataProvider?) {
        sweet(level: .debug, message: message, provider: provider, isProviderOptional: true)
    }
    
    func w(_ message: String, optional provider: SweetLoggerDataProvider?) {
        sweet(level: .warning, message: message, provider: provider, isProviderOptional: true)
    }
    
    func e(_ message: String, optional provider: SweetLoggerDataProvider?) {
        sweet(level: .error, message: message, provider: provider, isProviderOptional: true)
    }
}

// MARK: With Raw

public extension SweetLogger {
    func raw(_ message: String, _ raw: Any) {
        sweet(level: .verbose, message: message, raw: raw)
    }
}
