import SwiftUI
#if canImport(ArchitectureSharedDomain)
import ArchitectureSharedDomain
#endif

@main
struct ObservationMVVMApp: App {
    @State private var model = ObservationLessonModel(
        service: PersistedObservationLessonService(
            persistence: ObservationBookmarkPersistence(
                fileURL: Self.defaultBookmarksFileURL()
            )
        )
    )

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $model.path) {
                ObservationLessonListView(model: model)
            }
            .frame(minWidth: 760, minHeight: 540)
        }
    }

    private static func defaultBookmarksFileURL() -> URL {
        let baseDirectory = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first
            ?? FileManager.default.homeDirectoryForCurrentUser
        let appDirectory = baseDirectory.appendingPathComponent("PFJSwiftSd/ObservationMVVMApp", isDirectory: true)
        return appDirectory.appendingPathComponent("bookmarks.json")
    }
}
