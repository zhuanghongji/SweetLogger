//
//  File.swift
//
//
//  Created by 庄宏基 on 2023/10/27.
//

#if canImport(SwiftUI)
import SwiftUI

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension View {

    /// A wrapper of `onAppear(perform:)` and `onDisappear(perform:)`
    ///
    /// - Parameters:
    ///   - name: The name of view.
    @inlinable public func loggerAppearance(name: String) -> some View {
        onAppear {
            guard Logger.options.enabled else {
                return
            }
            Logger.raw("loggerAppearance", "onAppear(name: \"\(name)\")")
        }
        .onDisappear {
            guard Logger.options.enabled else {
                return
            }
            Logger.raw("loggerAppearance", "onDisappear(name: \"\(name)\")")
        }
    }
}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension View {

    /// A wrapper of `onChange(of:initial:_:)`
    ///
    /// - Parameters:
    ///   - value: The value to check against when determining whether to run the closure.
    ///   - initial: Whether the action should be run when this view initially appears.
    ///   - name: The name of value.
    public func loggerChange<V>(of value: V,
                                initial: Bool = false,
                                name: String = "")
        -> some View where V: Equatable
    {
        onChange(of: value, initial: initial) { oldValue, newValue in
            guard Logger.options.enabled else {
                return
            }
            let _name = name.isEmpty ? "" : "name: \"\(name)\", "
            
            let useDebugPrint = SweetLogger.options.useDebugPrint
            var _oldValue = useDebugPrint ? String(reflecting: oldValue) : String(describing: oldValue)
            if _oldValue.isEmpty {
                _oldValue = "__EmptyString__"
            }
            var _newValue = useDebugPrint ? String(reflecting: newValue) : String(describing: newValue)
            if _newValue.isEmpty {
                _newValue = "__EmptyString__"
            }

            let detail = "onChange(\(_name)oldValue: \(_oldValue), newValue: \(_newValue))"
            Logger.raw("loggerChange", detail)
        }
    }
}

#endif
