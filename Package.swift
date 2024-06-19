// swift-tools-version:5.7
import PackageDescription

let package = Package(
  name: "SimpleMetalApp",
  platforms: [
    .macOS(.v11)
  ],
  dependencies: [],
  targets: [
    .executableTarget(
      name: "SimpleMetalApp",
      dependencies: [])
  ]
)
