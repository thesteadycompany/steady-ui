// swift-tools-version: 6.3

import PackageDescription

let package = Package(
  name: "SteadyUI",
  platforms: [
    .iOS(.v18),
  ],
  products: [
    .library(
      name: "SteadyUI",
      targets: ["SteadyUI"]
    ),
  ],
  targets: [
    .target(
      name: "SteadyUI"
    ),
    .testTarget(
      name: "SteadyUITests",
      dependencies: ["SteadyUI"]
    ),
  ],
  swiftLanguageModes: [.v6]
)
