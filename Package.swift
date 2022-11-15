// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftLEB128",
    platforms: [
        .macOS(.v10_14),
        .iOS(.v14),
    ],
    products: [
        .library(
            name: "SwiftLEB128",
            targets: ["SwiftLEB128"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "SwiftLEB128",
            dependencies: []),
        .testTarget(
            name: "SwiftLEB128Tests",
            dependencies: ["SwiftLEB128"]),
    ]
)
