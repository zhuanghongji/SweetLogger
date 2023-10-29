//
//  Log.swift
//  Example
//
//  Created by zhuanghongji on 2023/10/29.
//

import SweetLogger

/// A simple wrapper of Logger in SweetLogger.
enum Log {
    static func initOptions() {
#if DEBUG
        Logger.options.enabled = true
#endif
    }
    
    static func t(_ tag: String) -> SweetLogger {
        Logger.t(tag)
    }
}

extension Log {
    static func v(_ message: String, _ items: Any..., separator: String = " ") {
        Logger.v(message, items, separator: separator)
    }
    
    static func i(_ message: String, _ items: Any..., separator: String = " ") {
        Logger.i(message, items, separator: separator)
    }
    
    static func d(_ message: String, _ items: Any..., separator: String = " ") {
        Logger.d(message, items, separator: separator)
    }
    
    static func w(_ message: String, _ items: Any..., separator: String = " ") {
        Logger.w(message, items, separator: separator)
    }
    
    static func e(_ message: String, _ items: Any..., separator: String = " ") {
        Logger.e(message, items, separator: separator)
    }
}

// MARK: With Data Provider

extension Log {
    static func v(_ message: String, data: SweetLoggerDataProvider) {
        Logger.v(message, data: data)
    }
    
    static func i(_ message: String, data: SweetLoggerDataProvider) {
        Logger.i(message, data: data)
    }
    
    static func d(_ message: String, data: SweetLoggerDataProvider) {
        Logger.d(message, data: data)
    }
    
    static func w(_ message: String, data: SweetLoggerDataProvider) {
        Logger.w(message, data: data)
    }
    
    static func e(_ message: String, data: SweetLoggerDataProvider) {
        Logger.e(message, data: data)
    }
}

// MARK: With Data Provider (Optional)

extension Log {
    static func v(_ message: String, optional: SweetLoggerDataProvider?) {
        Logger.v(message, optional: optional)
    }
    
    static func i(_ message: String, optional: SweetLoggerDataProvider?) {
        Logger.i(message, optional: optional)
    }
    
    static func d(_ message: String, optional: SweetLoggerDataProvider?) {
        Logger.d(message, optional: optional)
    }
    
    static func w(_ message: String, optional: SweetLoggerDataProvider?) {
        Logger.w(message, optional: optional)
    }
    
    static func e(_ message: String, optional: SweetLoggerDataProvider?) {
        Logger.e(message, optional: optional)
    }
}

// MARK: With Raw

extension Log {
    static func raw(_ message: String, _ raw: Any) {
        Logger.raw(message, raw)
    }
}
