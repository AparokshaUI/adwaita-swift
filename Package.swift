// swift-tools-version: 5.8
//
//  Package.swift
//  Adwaita
//
//  Created by david-swift on 08.06.23.
//

import PackageDescription

/// The Adwaita package.
let package = Package(
    name: "Adwaita",
    products: [
        .library(
            name: "Adwaita",
            targets: ["Adwaita"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/david-swift/SwiftGui", branch: "main")
    ],
    targets: [
        .target(
            name: "Adwaita",
            dependencies: [.product(name: "GTUI", package: "swiftgui")]
        ),
        .executableTarget(
            name: "Counter",
            dependencies: ["Adwaita"],
            path: "Tests"
        )
    ]
)
