//
//  Set.swift
//  Adwaita
//
//  Created by david-swift on 21.01.24.
//

// An extension
extension Set where Element == Edge {

    /// Horizontal and vertical edges.
    public static var all: Self { vertical.union(horizontal) }

    /// Top and bottom edges.
    public static var vertical: Self { top.union(bottom) }

    /// Leading and trailing edges.
    public static var horizontal: Self { leading.union(trailing) }

    /// Top edge.
    public static var top: Self { [.top] }

    /// Bottom edge.
    public static var bottom: Self { [.bottom] }

    /// Leading edge.
    public static var leading: Self { [.leading] }

    /// Trailing edge.
    public static var trailing: Self { [.trailing] }

    /// Add a collection of edges to a collection of edges.
    /// - Parameter edges: The collection of edges.
    /// - Returns: Both collections combined.
    public func add(_ edges: Self) -> Self { union(edges) }
}
