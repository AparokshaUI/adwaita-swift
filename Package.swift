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
        ),
        .library(
            name: "CAdw",
            targets: ["CAdw"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/david-swift/LevenshteinTransformations",
            from: "0.1.1"
        ),
        .package(url: "https://github.com/CoreOffice/XMLCoder", from: "0.17.1")
    ],
    targets: [
        .systemLibrary(
            name: "CAdw",
            pkgConfig: "libadwaita-1"
        ),
        .target(
            name: "Adwaita",
            dependencies: [
                "CAdw",
                .product(name: "LevenshteinTransformations", package: "LevenshteinTransformations")
            ]
        ),
        .executableTarget(
            name: "Generation",
            dependencies: [
                .product(name: "XMLCoder", package: "XMLCoder")
            ]
        ),
        .executableTarget(
            name: "Demo",
            dependencies: ["Adwaita"],
            path: "Tests"
        )
    ]
)
