// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.
// swiftlint:disable line_length

import PackageDescription

let package = Package(
    /// Build-Version: 0.3.21141002.1

    name: "SwiftUIGraph",
    platforms: [
        .macOS(.v10_15), .iOS(.v13), .tvOS(.v13), .watchOS(.v6)
    ],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "SwiftUIGraph",
            targets: ["SwiftUIGraph"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "SwiftUIGraph",
            dependencies: []),
        .testTarget(
            name: "SwiftUIGraphTests",
            dependencies: ["SwiftUIGraph"])
    ]
)
