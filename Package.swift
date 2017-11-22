// swift-tools-version:4.0

import PackageDescription

let package = Package(
  name: "Vaportrail",
  products: [
    // Logging plugin for Vapor
    .library(name: "Vaportrail", targets: ["Vaportrail"]),
    // Provider that runs Vaportrail server for integration in an existing app
    .library(name: "VaportrailServer", targets: ["VaportrailServer"]),
  ],
  dependencies: [
    .package(url: "https://github.com/vapor/vapor.git", .upToNextMajor(from: "2.2.0")),
    .package(url: "https://github.com/vapor/fluent-provider.git", from: "1.1.0"),
  ],
  targets: [
    // Logging plugin
    .target(name: "Vaportrail",
      dependencies: ["Vapor"]),
    .testTarget(name: "VaportrailTests",
      dependencies: ["Vaportrail", "VaportrailServer", "FluentProvider", "Vapor", "Testing"]),
    // Provider that runs the server
    .target(name: "VaportrailServer",
      dependencies: ["Vapor", "FluentProvider"]),
    .testTarget(name: "VaportrailServerTests",
      dependencies: ["VaportrailServer", "FluentProvider", "Vapor", "Testing"]),
  ]
)
