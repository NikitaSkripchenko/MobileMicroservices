import ProjectDescription

var swiftPackageManagerDependencies = SwiftPackageManagerDependencies(
    [
        .remote(url: "https://github.com/Swinject/Swinject", requirement: .upToNextMajor(from: "2.8.0")),
        .remote(url: "https://github.com/pointfreeco/swift-composable-architecture", requirement: .exact("1.2.0")),
        .remote(url: "https://github.com/pointfreeco/swift-case-paths", requirement: .exact("1.0.0"))
    ]
)

let dependencies = Dependencies(
    swiftPackageManager: swiftPackageManagerDependencies,
    platforms: [.iOS]
)
