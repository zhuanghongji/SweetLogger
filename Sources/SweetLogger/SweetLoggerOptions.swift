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

    /// The brand text that using in each output.
    ///
    /// You can use it as a global tag. If you don't need that, just set it to an empty string.
    public var brand = "Sweet"

    /// The date format in output.
    ///
    /// The default value is "HH:mm:ss.SSSS" and it will produce an output like "12:01:02.0003".
    ///
    /// - If you require more detailed infomation including the year, month and day, you can use "yyyy-MM-dd HH:mm:ss.SSSS" instead.
    /// - If you don't need any time infomation, simply set it as an empty string.
    public var dateFormat = "HH:mm:ss.SSSS"

    /// The flag is used before the message to separate it from contextual information.
    public var separator = ":"

    /// The global terminator for dividing each block of Logger output.
    ///
    /// If you prefer a more noticeable terminator, "\n--------------------\n\n" is an option.
    public var terminator = "\n"

    /// When enabled, the output will be prefixed with an emojj that corresponds to the level.
    public var useLevelSymbol = true

    /// When enabled, the output will be prefixed with a brief descrition that corresponds to the level.
    public var useLevelDescrition = true

    /// The print function switcher.
    ///
    /// If is is true, the Logger will use `debugPrint(_:separator:terminator:)`.
    /// Othersise, the Logger will use `print(_:separator:terminator:)` instead.
    public var useDebugPrint = true
}
