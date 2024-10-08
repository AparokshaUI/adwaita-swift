//
//  Int.swift
//  Adwaita
//
//  Created by david-swift on 15.01.24.
//

extension Int: @retroactive Identifiable {

    /// Get the integer itself as the identifier.
    public var id: Int { self }
    /// The C integer.
    public var cInt: Int32 {
        .init(truncatingIfNeeded: self)
    }

}
