import Foundation

public enum LessonTrack: String, CaseIterable, Codable {
    case foundations
    case language
    case concurrency
    case swiftUI = "swiftui"
    case architecture
}

public struct Lesson: Identifiable, Codable, Hashable {
    public let id: UUID
    public let title: String
    public let track: LessonTrack
    public let estimatedMinutes: Int

    public init(id: UUID, title: String, track: LessonTrack, estimatedMinutes: Int) {
        self.id = id
        self.title = title
        self.track = track
        self.estimatedMinutes = estimatedMinutes
    }
}

public struct DashboardState {
    public var lessons: [Lesson] = []
    public var isLoading = false
    public var selectedTrack: LessonTrack?
    public var searchQuery = ""
    public var bookmarkedLessonIDs: Set<UUID> = []
    public var errorMessage: String?

    public init(
        lessons: [Lesson] = [],
        isLoading: Bool = false,
        selectedTrack: LessonTrack? = nil,
        searchQuery: String = "",
        bookmarkedLessonIDs: Set<UUID> = [],
        errorMessage: String? = nil
    ) {
        self.lessons = lessons
        self.isLoading = isLoading
        self.selectedTrack = selectedTrack
        self.searchQuery = searchQuery
        self.bookmarkedLessonIDs = bookmarkedLessonIDs
        self.errorMessage = errorMessage
    }

    public var visibleLessons: [Lesson] {
        lessons.filter { lesson in
            let matchesTrack = selectedTrack.map { lesson.track == $0 } ?? true
            let normalizedQuery = searchQuery.trimmingCharacters(in: .whitespacesAndNewlines)
            let matchesQuery = normalizedQuery.isEmpty
                || lesson.title.localizedCaseInsensitiveContains(normalizedQuery)
                || lesson.track.rawValue.localizedCaseInsensitiveContains(normalizedQuery)
            return matchesTrack && matchesQuery
        }
    }
}

public enum DashboardAction {
    case loadTapped
    case lessonsLoaded([Lesson])
    case failed(String)
    case searchChanged(String)
    case trackChanged(LessonTrack?)
    case bookmarksLoaded(Set<UUID>)
    case bookmarkToggled(UUID)
}

public enum DashboardStoreError: Error {
    case loadFailed
    case saveFailed
}
