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
        .executable(
            name: "StudyDashboardApp",
            targets: ["StudyDashboardApp"]
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
        .executableTarget(
            name: "StudyDashboardApp",
            dependencies: ["StudyDashboardFeatureCore"],
            path: "apps/StudyDashboardApp/Sources"
        ),
    ]
)
