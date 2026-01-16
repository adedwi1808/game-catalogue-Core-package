// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Core",
    platforms: [.iOS(.v15)],
    products: [
        .library(name: "Core", targets: ["Core"]),
    ],
    dependencies: [
        .package(path: "../Common"),
        .package(url: "https://github.com/realm/realm-swift.git", from: "10.54.2")
    ],
    targets: [
        .target(
            name: "Core",
            dependencies: [
                "Common",
                .product(name: "RealmSwift", package: "realm-swift")
            ]
        ),
    ]
)
