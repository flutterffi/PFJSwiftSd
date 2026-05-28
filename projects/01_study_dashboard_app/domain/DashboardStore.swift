import Foundation

struct DashboardEnvironment {
    var fetchLessons: () async throws -> [Lesson]
    var loadBookmarks: () throws -> Set<UUID>
    var saveBookmarks: (Set<UUID>) throws -> Void
}

struct DashboardStore {
    private(set) var state: DashboardState
    let environment: DashboardEnvironment

    init(
        state: DashboardState = DashboardState(),
        environment: DashboardEnvironment
    ) {
        self.state = state
        self.environment = environment
    }

    mutating func send(_ action: DashboardAction) async {
        switch action {
        case .loadTapped:
            state.isLoading = true
            state.errorMessage = nil

            do {
                let lessons = try await environment.fetchLessons()
                let bookmarks = try environment.loadBookmarks()
                await send(.lessonsLoaded(lessons))
                await send(.bookmarksLoaded(bookmarks))
            } catch {
                await send(.failed("Unable to load dashboard data"))
            }

        case let .lessonsLoaded(lessons):
            state.isLoading = false
            state.lessons = lessons

        case let .failed(message):
            state.isLoading = false
            state.errorMessage = message

        case let .searchChanged(query):
            state.searchQuery = query

        case let .trackChanged(track):
            state.selectedTrack = track

        case let .bookmarksLoaded(bookmarks):
            state.bookmarkedLessonIDs = bookmarks

        case let .bookmarkToggled(id):
            if state.bookmarkedLessonIDs.contains(id) {
                state.bookmarkedLessonIDs.remove(id)
            } else {
                state.bookmarkedLessonIDs.insert(id)
            }

            do {
                try environment.saveBookmarks(state.bookmarkedLessonIDs)
            } catch {
                state.errorMessage = "Unable to save bookmarks"
            }
        }
    }
}
