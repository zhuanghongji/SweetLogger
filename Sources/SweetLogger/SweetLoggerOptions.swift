//
//  SweetLoggerOptions.swift
//  Example
//
//  Created by 庄宏基 on 2023/10/24.
//

import Foundation

public class SweetLoggerOptions {

    /// Printing control, default is off.
    public var enabled: Bool = false

    /// Using in each output as a global tag.
    public var brand = "Sweet"

    /// Custom date format for output.
    ///
    /// The default value is "HH:mm:ss.SSSS" and it will produce an output like "12:01:02.0003".
    ///
    /// - If you require more detailed infomation including the year, month and day, you can use "yyyy-MM-dd HH:mm:ss.SSSS".
    /// - If you do not need any time infomation, simply set it as an empty string.
    public var dateFormat = "HH:mm:ss.SSSS"

    /// The flag is used before the message to separate it from contextual information.
    public var separator = ":"

    /// The terminator divide each block of Logger output.
    ///
    /// If you prefer a more noticeable divider, "\n--------------------\n\n" is an option.
    public var divider = "\n"

    /// The print function switcher.
    ///
    /// - The default is false, and the Logger will use `print(_:separator:terminator:)`.
    /// - If it is false, the Logger will use `debugPrint(_:separator:terminator:)`.
    public var useDebugPrint = false
}
