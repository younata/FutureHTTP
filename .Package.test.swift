import PackageDescription

let package = Package(
    name: "FutureHTTP",
    dependencies: [
        .Package(url: "https://github.com/antitypical/Result.git", majorVersion: 3),
        .Package(url: "https://github.com/cbguder/CBGPromise.git", majorVersion: 0, minor: 4),

        .Package(url: "https://github.com/Quick/Quick", majorVersion: 1, minor: 1),
        .Package(url: "https://github.com/Quick/Nimble", majorVersion: 6)
    ]
)
