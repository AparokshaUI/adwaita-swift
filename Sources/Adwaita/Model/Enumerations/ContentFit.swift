//
//  ContentFit.swift
//  Adwaita
//
//  Created by david-swift on 19.07.24.
//

import CAdw

/// Control how a content should be made to fit inside an allocation.
public enum ContentFit: UInt32 {

    /// Make the content fill the entire allocation,
    /// without taking its aspect ratio in consideration.
    case fill
    /// Scale the content to fit the allocation,
    /// while taking its aspect ratio in consideration.
    case contain
    /// Cover the entire allocation,
    /// while taking the content aspect ratio in consideration.
    case cover
    /// The content is scaled down to fit the allocation, if needed,
    /// otherwise its original size is used.
    case scaleDown

    /// The ContentFit value as a GtkContentFit value.
    var gtkValue: GtkContentFit {
        .init(rawValue)
    }

}
