// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SkyWizardAPI",
    platforms: [.iOS(.v16)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SkyWizardModel",
            targets: ["SkyWizardModel"]),
        .library(
            name: "SkyWizardEnum",
            targets: ["SkyWizardEnum"]
        ),
        .library(
            name: "SkyWizardService",
            targets: ["SkyWizardService"]
        ),
        .library(
            name: "SkyWizardLogger",
            targets: ["SkyWizardLogger"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/hishd/NetworkingService", .upToNextMajor(from: "1.0.4")),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(name: "SkyWizardModel", dependencies: ["SkyWizardEnum"]),
        .target(name: "SkyWizardEnum"),
        .target(name: "SkyWizardService", dependencies: ["SkyWizardModel", "NetworkingService", "SkyWizardLogger"]),
        .target(name: "SkyWizardLogger"),
        .testTarget(
            name: "SkyWizardAPITests"
        ),
    ]
)
