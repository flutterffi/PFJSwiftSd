// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "PFJSwiftSd",
    platforms: [
        .macOS(.v14),
    ],
    products: [
        .library(
            name: "StudyDashboardFeatureCore",
            targets: ["StudyDashboardFeatureCore"]
        ),
        .library(
            name: "ArchitectureSharedDomain",
            targets: ["ArchitectureSharedDomain"]
        ),
        .executable(
            name: "FoundationsRunner",
            targets: ["FoundationsRunner"]
        ),
        .executable(
            name: "StudyDashboardApp",
            targets: ["StudyDashboardApp"]
        ),
        .executable(
            name: "MVVMSwiftUIApp",
            targets: ["MVVMSwiftUIApp"]
        ),
        .executable(
            name: "ObservationMVVMApp",
            targets: ["ObservationMVVMApp"]
        ),
    ],
    targets: [
        .target(
            name: "StudyDashboardFeatureCore",
            path: "projects/01_study_dashboard_app",
            exclude: [
                "README.md",
                "bookmarks.json",
                "study_dashboard_feature.swift",
                "tests",
            ]
        ),
        .target(
            name: "ArchitectureSharedDomain",
            path: "apps/ArchitecturePlayground/SharedDomain",
            exclude: [
                "README.md",
            ]
        ),
        .executableTarget(
            name: "FoundationsRunner",
            path: "Sources/FoundationsRunner"
        ),
        .executableTarget(
            name: "StudyDashboardApp",
            dependencies: ["StudyDashboardFeatureCore"],
            path: "apps/StudyDashboardApp/Sources"
        ),
        .executableTarget(
            name: "MVVMSwiftUIApp",
            dependencies: ["ArchitectureSharedDomain"],
            path: "apps/ArchitecturePlayground/MVVMSwiftUIApp/Sources"
        ),
        .executableTarget(
            name: "ObservationMVVMApp",
            dependencies: ["ArchitectureSharedDomain"],
            path: "apps/ArchitecturePlayground/ObservationMVVMApp/Sources"
        ),
        .testTarget(
            name: "StudyDashboardFeatureCoreTests",
            dependencies: ["StudyDashboardFeatureCore"],
            path: "Tests/StudyDashboardFeatureCoreTests"
        ),
        .testTarget(
            name: "MVVMSwiftUIAppTests",
            dependencies: ["ArchitectureSharedDomain", "MVVMSwiftUIApp"],
            path: "Tests/MVVMSwiftUIAppTests"
        ),
    ]
)
