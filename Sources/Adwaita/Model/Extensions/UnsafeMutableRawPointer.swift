//
//  UnsafeMutableRawPointer.swift
//  Adwaita
//
//  Created by david-swift on 15.01.24.
//

extension UnsafeMutableRawPointer {

    /// Convert into an unsafe mutable pointer of a certain type.
    /// - Returns: The unsafe mutable pointer.
    public func cast<T>() -> UnsafeMutablePointer<T> {
        let pointer = UnsafeMutableRawPointer(self).bindMemory(to: T.self, capacity: 1)
        return UnsafeMutablePointer<T>(mutating: pointer)
    }

}
