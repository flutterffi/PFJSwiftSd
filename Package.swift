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
            name: "MVCApp",
            targets: ["MVCApp"]
        ),
        .executable(
            name: "MVPApp",
            targets: ["MVPApp"]
        ),
        .executable(
            name: "MVVMUIKitApp",
            targets: ["MVVMUIKitApp"]
        ),
        .executable(
            name: "VIPERApp",
            targets: ["VIPERApp"]
        ),
        .executable(
            name: "ReducerStyleApp",
            targets: ["ReducerStyleApp"]
        ),
        .executable(
            name: "CoordinatorMVVMApp",
            targets: ["CoordinatorMVVMApp"]
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
            name: "MVCApp",
            dependencies: ["ArchitectureSharedDomain"],
            path: "apps/ArchitecturePlayground/MVCApp/Sources"
        ),
        .executableTarget(
            name: "MVPApp",
            dependencies: ["ArchitectureSharedDomain"],
            path: "apps/ArchitecturePlayground/MVPApp/Sources"
        ),
        .executableTarget(
            name: "MVVMUIKitApp",
            dependencies: ["ArchitectureSharedDomain"],
            path: "apps/ArchitecturePlayground/MVVMUIKitApp/Sources"
        ),
        .executableTarget(
            name: "VIPERApp",
            dependencies: ["ArchitectureSharedDomain"],
            path: "apps/ArchitecturePlayground/VIPERApp/Sources"
        ),
        .executableTarget(
            name: "ReducerStyleApp",
            dependencies: ["ArchitectureSharedDomain"],
            path: "apps/ArchitecturePlayground/ReducerStyleApp/Sources"
        ),
        .executableTarget(
            name: "CoordinatorMVVMApp",
            dependencies: ["ArchitectureSharedDomain"],
            path: "apps/ArchitecturePlayground/CoordinatorMVVMApp/Sources"
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
        .testTarget(
            name: "ObservationMVVMAppTests",
            dependencies: ["ArchitectureSharedDomain", "ObservationMVVMApp"],
            path: "Tests/ObservationMVVMAppTests"
        ),
        .testTarget(
            name: "UIKitArchitectureComparisonTests",
            dependencies: [
                "ArchitectureSharedDomain",
                "MVCApp",
                "MVPApp",
                "MVVMUIKitApp",
                "VIPERApp",
            ],
            path: "Tests/UIKitArchitectureComparisonTests"
        ),
        .testTarget(
            name: "UIKitSwiftUIMigrationTests",
            dependencies: [
                "ArchitectureSharedDomain",
                "MVVMUIKitApp",
                "MVVMSwiftUIApp",
            ],
            path: "Tests/UIKitSwiftUIMigrationTests"
        ),
        .testTarget(
            name: "MVVMObservationComparisonTests",
            dependencies: [
                "ArchitectureSharedDomain",
                "MVVMSwiftUIApp",
                "ObservationMVVMApp",
            ],
            path: "Tests/MVVMObservationComparisonTests"
        ),
        .testTarget(
            name: "ReducerStyleAppTests",
            dependencies: [
                "ArchitectureSharedDomain",
                "ReducerStyleApp",
            ],
            path: "Tests/ReducerStyleAppTests"
        ),
        .testTarget(
            name: "MVVMReducerComparisonTests",
            dependencies: [
                "ArchitectureSharedDomain",
                "MVVMSwiftUIApp",
                "ReducerStyleApp",
            ],
            path: "Tests/MVVMReducerComparisonTests"
        ),
        .testTarget(
            name: "CoordinatorMVVMAppTests",
            dependencies: [
                "ArchitectureSharedDomain",
                "CoordinatorMVVMApp",
            ],
            path: "Tests/CoordinatorMVVMAppTests"
        ),
        .testTarget(
            name: "MVVMCoordinatorComparisonTests",
            dependencies: [
                "ArchitectureSharedDomain",
                "MVVMSwiftUIApp",
                "CoordinatorMVVMApp",
            ],
            path: "Tests/MVVMCoordinatorComparisonTests"
        ),
    ]
)
