//
//  Carousel+.swift
//  Adwaita
//
//  Created by david-swift on 18.01.24.
//

extension Carousel {

    /// Set whether long swipes are allowed or not.
    /// - Parameter longSwipes: Whether long swipes are allowed.
    /// - Returns: The carousel.
    public func longSwipes(_ longSwipes: Bool = true) -> Self {
        allowLongSwipes(longSwipes)
    }

}
