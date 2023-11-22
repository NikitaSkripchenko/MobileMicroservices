import ProjectDescription
import ProjectDescriptionHelpers
import MyPlugin

/*
                +-------------+
                |             |
                |     App     | Contains Opora App target and Opora unit-test target
                |             |
         +------+-------------+-------+
         |         depends on         |
         |                            |
 +----v-----+                   +-----v-----+
 |          |                   |           |
 |   Kit    |                   |     UI    |   Two independent frameworks to share code and start modularising your app
 |          |                   |           |
 +----------+                   +-----------+

 */

// MARK: - Project

// Local plugin loaded
let localHelper = LocalHelper(name: "MyPlugin")

// Creates our project using a helper function defined in ProjectDescriptionHelpers
//let project = Project.app(name: "Opora",
//                          platform: .iOS,
//                          additionalTargets: ["OporaKit", "OporaUI"])
let project = Project(
    name: "Opora",
    organizationName: "OporaOrg",
//    additionalTargets: ["OporaKit", "OporaUI"],
    targets: [
        Target(
            name: "MVCApp",
            platform: .iOS,
            product: .app,
            bundleId: "com.yourcompany.MVCApp",
            infoPlist: .default,
            sources: ["Sources/MVCApp/**"],
            dependencies: [
                .target(name: "SharedServices")
            ]
        ),
        Target(
            name: "TCAApp",
            platform: .iOS,
            product: .app,
            bundleId: "com.yourcompany.TCAApp",
            infoPlist: .default,
            sources: ["Sources/TCAApp/**"],
            dependencies: [
                .target(name: "SharedServices")
            ]
        ),
        Target(
            name: "ViperApp",
            platform: .iOS,
            product: .app,
            bundleId: "com.yourcompany.ViperApp",
            infoPlist: .default,
            sources: ["Sources/ViperApp/**", "Sources/SharedServices/**"],
            dependencies: [
                .target(name: "SharedServices")
            ]
        ),
        Target(
            name: "MVVMApp",
            platform: .iOS,
            product: .app,
            bundleId: "com.yourcompany.MVVMApp",
            infoPlist: .default,
            sources: ["Sources/MVVMApp/**"],
            dependencies: [
                .target(name: "SharedServices")
            ]
        ),
        Target(
            name: "SharedServices",
            platform: .iOS,
            product: .framework,  // Specify static library product type
            bundleId: "com.yourcompany.SharedServices",
            infoPlist: .default,
            sources: ["Sources/SharedServices/**"]
        )
    ]
)
