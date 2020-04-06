// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "FutureHTTP",
    products: [
        .library(name: "FutureHTTP", targets: ["FutureHTTP"]),
    ],
    dependencies: [
        .package(url: "https://github.com/cbguder/CBGPromise.git", from: "0.6.0"),
    ],
    targets: [
        .target(name: "FutureHTTP", dependencies: ["CBGPromise"], path: "Sources"),
        .testTarget(name: "FutureHTTPTests", dependencies: ["FutureHTTP"])
    ]
)
