import Foundation

public struct DashboardEnvironment {
    public var fetchLessons: () async throws -> [Lesson]
    public var loadBookmarks: () throws -> Set<UUID>
    public var saveBookmarks: (Set<UUID>) throws -> Void

    public init(
        fetchLessons: @escaping () async throws -> [Lesson],
        loadBookmarks: @escaping () throws -> Set<UUID>,
        saveBookmarks: @escaping (Set<UUID>) throws -> Void
    ) {
        self.fetchLessons = fetchLessons
        self.loadBookmarks = loadBookmarks
        self.saveBookmarks = saveBookmarks
    }
}

public struct DashboardStore {
    public private(set) var state: DashboardState
    public let environment: DashboardEnvironment

    public init(
        state: DashboardState = DashboardState(),
        environment: DashboardEnvironment
    ) {
        self.state = state
        self.environment = environment
    }

    public mutating func send(_ action: DashboardAction) async {
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
