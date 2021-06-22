// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PreciseDecimal",
    products: [
        .library(
            name: "PreciseDecimal",
            targets: ["PreciseDecimal"]
        ),
    ],
    targets: [
        .target(
            name: "PreciseDecimal",
            dependencies: []
        ),
        .testTarget(
            name: "PreciseDecimalTests",
            dependencies: ["PreciseDecimal"]
        ),
    ]
)
