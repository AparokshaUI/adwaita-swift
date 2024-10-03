//
//  ViewStorage.swift
//  Adwaita
//
//  Created by david-swift on 01.08.24.
//

extension ViewStorage {

    /// Modify the view.
    /// - Parameter modify: The modification function.
    public func modify(_ modify: (OpaquePointer?) -> Void) {
        modify(opaquePointer)
    }

    /// Convert the pointer to a pointer of a certain type and modify the view.
    /// - Parameters:
    ///     - type: The pointer's type.
    ///     - modify: The modification function.
    public func modify<T>(_ type: T.Type, _ modify: (UnsafeMutablePointer<T>?) -> Void) {
        modify(opaquePointer?.cast())
    }

}
