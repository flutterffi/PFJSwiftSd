import Foundation
#if canImport(StudyDashboardFeatureCore)
import StudyDashboardFeatureCore
#endif

@MainActor
final class DashboardViewModel: ObservableObject {
    @Published private(set) var state = DashboardState()

    private let environment: DashboardEnvironment

    init(environment: DashboardEnvironment? = nil) {
        self.environment = environment ?? makeDashboardEnvironment(
            bookmarksFileURL: Self.defaultBookmarksFileURL()
        )
    }

    func loadIfNeeded() async {
        guard state.lessons.isEmpty, !state.isLoading else {
            return
        }

        await send(.loadTapped)
    }

    func searchChanged(_ query: String) async {
        await send(.searchChanged(query))
    }

    func trackChanged(_ track: LessonTrack?) async {
        await send(.trackChanged(track))
    }

    func toggleBookmark(for lessonID: UUID) async {
        await send(.bookmarkToggled(lessonID))
    }

    private func send(_ action: DashboardAction) async {
        var store = DashboardStore(state: state, environment: environment)
        await store.send(action)
        state = store.state
    }

    private static func defaultBookmarksFileURL() -> URL {
        let baseDirectory = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first
            ?? FileManager.default.homeDirectoryForCurrentUser
        let appDirectory = baseDirectory.appendingPathComponent("PFJSwiftSd", isDirectory: true)

        try? FileManager.default.createDirectory(at: appDirectory, withIntermediateDirectories: true)
        return appDirectory.appendingPathComponent("bookmarks.json")
    }
}
