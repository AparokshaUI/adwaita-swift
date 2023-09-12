//
//  NativeWidgetPeer.swift
//  Adwaita
//
//  Created by david-swift on 05.08.23.
//

import GTUI

extension NativeWidgetPeer: Widget {

    /// A `GTUI.NativeWidgetPeer` is static.
    /// - Parameter storage: The view storage.
    public func update(_ storage: ViewStorage) { }

    /// A `GTUI.NativeWidgetPeer`'s container is itself.
    /// - Returns: The view storage.
    public func container() -> ViewStorage {
        let bold = "\(modifier(code: 1))"
        let yellow = 33
        let warning = "\(modifier(code: yellow))\(bold)"
        let reset = modifier(code: 0)
        print("\(warning)warning: \(reset)discouraged use of GTUI widgets (here: \(bold)\(Self.self)\(reset)) in views")
        return .init(self)
    }

    /// Get a modifier stirng.
    /// - Parameter code: The modifier.
    /// - Returns: The string.
    private func modifier(code: Int) -> String {
        "\u{001B}[\(code)m"
    }

}
