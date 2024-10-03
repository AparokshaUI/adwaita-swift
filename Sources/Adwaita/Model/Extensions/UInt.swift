//
//  UInt.swift
//  Adwaita
//
//  Created by david-swift on 19.01.24.
//

extension UInt {

    /// Convert an unsigned integer into the C form.
    public var cInt: UInt32 {
        .init(truncatingIfNeeded: self)
    }

}
