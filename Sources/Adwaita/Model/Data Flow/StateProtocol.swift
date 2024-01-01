//
//  StateProtocol.swift
//  Adwaita
//
//  Created by david-swift on 09.09.23.
//

/// An interface for accessing `State` without specifying the generic type.
public protocol StateProtocol {

    /// The class storing the value.
    var content: State<Any>.Content { get }

}
