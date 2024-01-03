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
        .package(url: "https://github.com/AparokshaUI/Libadwaita", from: "0.1.5"),
        .package(
            url: "https://github.com/david-swift/LevenshteinTransformations",
            from: "0.1.1"
        )
    ],
    targets: [
        .target(
            name: "Adwaita",
            dependencies: [
                .product(name: "Libadwaita", package: "Libadwaita"),
                .product(name: "LevenshteinTransformations", package: "LevenshteinTransformations")
            ]
        ),
        .executableTarget(
            name: "Swift Adwaita Demo",
            dependencies: ["Adwaita"],
            path: "Tests"
        )
    ]
)
