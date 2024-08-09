//
//  Bool.swift
//  Adwaita
//
//  Created by david-swift on 15.01.24.
//

// An extension
extension Bool {

    /// Get the gboolean for C.
    public var cBool: Int32 {
        self ? 1 : 0
    }

}
