//
//  StateProtocol.swift
//  Adwaita
//
//  Created by david-swift on 09.09.23.
//

/// An interface for accessing `State` without specifying the generic type.
public protocol StateProtocol {

    /// The type-erased value.
    var value: Any { get nonmutating set }

}
