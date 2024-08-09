//
//  OpaquePointer.swift
//  Adwaita
//
//  Created by david-swift on 15.01.23.
//

// An extension
extension OpaquePointer {

    /// Convert an opaque pointer into an unsafe mutable pointer with a defined type.
    /// - Returns: The unsafe mutable pointer.
    public func cast<T>() -> UnsafeMutablePointer<T> {
        .init(self)
    }

}
