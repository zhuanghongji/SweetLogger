//
//  Logger.swift
//  SweetLogger
//
//  Created by zhuanghongji on 2023/10/24.
//

import Foundation

/// The main api interface of SweetLogger
public enum Logger {
    
    /// Get options
    public static var options: SweetLoggerOptions {
        SweetLogger.options
    }
    
    /// Get a new `SweetLogger` instance by specified tag name
    public static func t(_ tag: String) -> SweetLogger {
        if SweetLogger.options.enabled {
            SweetLogger(tag: tag)
        } else {
            SweetLogger.shared
        }
    }
}

// MARK: With Items

public extension Logger {
    
    /// Print message with items provider in verbose level
    static func v(_ message: String, _ items: Any..., separator: String = " ") {
        SweetLogger.shared.v(message, items, separator: separator)
    }
    
    /// Print message in info level without data provider
    static func i(_ message: String, _ items: Any..., separator: String = " ") {
        SweetLogger.shared.i(message, items, separator: separator)
    }
    
    /// Print message in debug level without data provider
    static func d(_ message: String, _ items: Any..., separator: String = " ") {
        SweetLogger.shared.d(message, items, separator: separator)
    }
    
    /// Print message in warning level without data provider
    static func w(_ message: String, _ items: Any..., separator: String = " ") {
        SweetLogger.shared.w(message, items, separator: separator)
    }
    
    /// Print message in error level without data provider
    static func e(_ message: String, _ items: Any..., separator: String = " ") {
        SweetLogger.shared.e(message, items, separator: separator)
    }
}
 
// MARK: With Data Provider

public extension Logger {
    
    /// Print message with data provider in verbose level
    static func v(_ message: String, data: SweetLoggerDataProvider) {
        SweetLogger.shared.v(message, data: data)
    }
    
    /// Print message in info level with data provider
    static func i(_ message: String, data: SweetLoggerDataProvider) {
        SweetLogger.shared.i(message, data: data)
    }
    
    /// Print message in debug level with data provider
    static func d(_ message: String, data: SweetLoggerDataProvider) {
        SweetLogger.shared.d(message, data: data)
    }
    
    /// Print message in warning level with data provider
    static func w(_ message: String, data: SweetLoggerDataProvider) {
        SweetLogger.shared.w(message, data: data)
    }
    
    /// Print message in error level with data provider
    static func e(_ message: String, data: SweetLoggerDataProvider) {
        SweetLogger.shared.e(message, data: data)
    }
}

// MARK: With Data Provider (Optional)

public extension Logger {
    
    /// Print message in verbose level with optional data provider
    static func v(_ message: String, optional: SweetLoggerDataProvider?) {
        SweetLogger.shared.v(message, optional: optional)
    }
    
    /// Print message in info level with optional data provider
    static func i(_ message: String, optional: SweetLoggerDataProvider?) {
        SweetLogger.shared.i(message, optional: optional)
    }
    
    /// Print message in debug level with optional data provider
    static func d(_ message: String, optional: SweetLoggerDataProvider?) {
        SweetLogger.shared.d(message, optional: optional)
    }
    
    /// Print message in warning level with optional data provider
    static func w(_ message: String, optional: SweetLoggerDataProvider?) {
        SweetLogger.shared.w(message, optional: optional)
    }
    
    /// Print message in error level with optional data provider
    static func e(_ message: String, optional: SweetLoggerDataProvider?) {
        SweetLogger.shared.e(message, optional: optional)
    }
}

// MARK: With Raw

public extension Logger {
    
    /// Print message in verbose level with raw content.
    static func raw(_ message: String, _ raw: Any) {
        SweetLogger.shared.raw(message, raw)
    }
}
