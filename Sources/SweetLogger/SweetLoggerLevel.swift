//
//  SweetLoggerLevel.swift
//  Example
//
//  Created by 庄宏基 on 2023/10/24.
//

import Foundation

enum SweetLoggerLevel: String {
    case verbose
    case info
    case debug
    case warning
    case error
}

extension SweetLoggerLevel {
    var symbol: String {
        switch self {
        case .verbose:
            "⚪️"
        case .info:
            "🟢"
        case .debug:
            "🔵"
        case .warning:
            "🟠"
        case .error:
            "🔴"
        }
    }
}

extension SweetLoggerLevel: CustomStringConvertible {
    var description: String {
        switch self {
        case .verbose:
            "[V]"
        case .info:
            "[I]"
        case .debug:
            "[D]"
        case .warning:
            "[W]"
        case .error:
            "[E]"
        }
    }
}
