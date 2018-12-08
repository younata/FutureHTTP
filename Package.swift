// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "FutureHTTP",
    products: [
        .library(name: "FutureHTTP", targets: ["FutureHTTP"]),
    ],
    dependencies: [
        .package(url: "https://github.com/antitypical/Result.git", .upToNextMinor(from: "4.0.0")),
        .package(url: "https://github.com/cbguder/CBGPromise.git", .upToNextMinor(from: "0.5.0")),

        .package(url: "https://github.com/quick/Quick.git", .upToNextMinor(from: "1.3.2")),
        .package(url: "https://github.com/quick/Nimble.git", .upToNextMinor(from: "7.3.1"))
    ],
    targets: [
        .target(name: "FutureHTTP", dependencies: ["Result", "CBGPromise"], path: "Sources"),
        .testTarget(name: "FutureHTTPTests", dependencies: ["FutureHTTP", "Quick", "Nimble"])
    ]
)
