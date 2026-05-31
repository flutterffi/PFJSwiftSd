import SwiftUI
#if canImport(ArchitectureSharedDomain)
import ArchitectureSharedDomain
#endif

@main
struct MVVMSwiftUIApp: App {
    @StateObject private var viewModel = MVVMLessonListViewModel(
        service: PersistedMVVMLessonService(
            persistence: MVVMBookmarkPersistence(
                fileURL: Self.defaultBookmarksFileURL()
            )
        )
    )

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $viewModel.path) {
                MVVMLessonListView(viewModel: viewModel)
            }
            .frame(minWidth: 760, minHeight: 540)
        }
    }

    private static func defaultBookmarksFileURL() -> URL {
        let baseDirectory = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first
            ?? FileManager.default.homeDirectoryForCurrentUser
        let appDirectory = baseDirectory.appendingPathComponent("PFJSwiftSd/MVVMSwiftUIApp", isDirectory: true)
        return appDirectory.appendingPathComponent("bookmarks.json")
    }
}
