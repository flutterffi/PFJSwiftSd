import Foundation

func printDashboard(_ state: DashboardState, title: String) {
    print("\n=== \(title) ===")
    print("Loading:", state.isLoading)
    print("Selected track:", state.selectedTrack?.rawValue ?? "all")
    print("Search query:", state.searchQuery.isEmpty ? "<empty>" : state.searchQuery)
    print("Bookmarks:", state.bookmarkedLessonIDs.count)

    for lesson in state.visibleLessons {
        let bookmarkMark = state.bookmarkedLessonIDs.contains(lesson.id) ? "★" : " "
        print("\(bookmarkMark) \(lesson.title) [\(lesson.track.rawValue)] - \(lesson.estimatedMinutes)m")
    }

    if let errorMessage = state.errorMessage {
        print("Error:", errorMessage)
    }
}

@main
struct StudyDashboardFeatureDemo {
    static func main() async {
        let bookmarksFileURL = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
            .appendingPathComponent("projects/01_study_dashboard_app/bookmarks.json")

        var store = DashboardStore(
            environment: makeDashboardEnvironment(bookmarksFileURL: bookmarksFileURL)
        )

        await store.send(.loadTapped)
        printDashboard(store.state, title: "Initial Load")

        await store.send(.searchChanged("task"))
        printDashboard(store.state, title: "Search: task")

        await store.send(.trackChanged(.swiftUI))
        printDashboard(store.state, title: "Track: swiftui")

        await store.send(.searchChanged(""))
        if let lesson = store.state.lessons.first(where: { $0.track == .swiftUI }) {
            await store.send(.bookmarkToggled(lesson.id))
        }
        printDashboard(store.state, title: "After Bookmark Toggle")
    }
}
