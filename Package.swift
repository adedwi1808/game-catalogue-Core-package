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
        .package(url: "https://github.com/adedwi1808/game-catalogue-Common-package.git", from: "1.0.0"),
        .package(url: "https://github.com/realm/realm-swift.git", branch: "master")
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
