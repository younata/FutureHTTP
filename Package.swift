// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "FutureHTTP",
    products: [
        .library(name: "FutureHTTP", targets: ["FutureHTTP"]),
    ],
    dependencies: [
        .package(url: "https://github.com/antitypical/Result.git", from: "4.1.0"),
        .package(url: "https://github.com/cbguder/CBGPromise.git", from: "0.5.0"),

        .package(url: "https://github.com/quick/Quick.git", from: "2.0.0"),
        .package(url: "https://github.com/quick/Nimble.git", from: "8.0.1")
    ],
    targets: [
        .target(name: "FutureHTTP", dependencies: ["Result", "CBGPromise"], path: "Sources"),
        .testTarget(name: "FutureHTTPTests", dependencies: ["FutureHTTP", "Quick", "Nimble"])
    ]
)
