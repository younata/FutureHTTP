import PackageDescription

let package = Package(
    name: "FutureHTTP",
    dependencies: [
        .Package(url: "https://github.com/antitypical/Result.git", majorVersion: 3),
        .Package(url: "https://github.com/cbguder/CBGPromise.git", majorVersion: 0, minor: 4)
    ]
)
