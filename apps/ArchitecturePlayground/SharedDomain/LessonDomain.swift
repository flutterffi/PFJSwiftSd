import Foundation

public enum ArchitectureLessonTrack: String, CaseIterable, Codable {
    case foundations
    case language
    case concurrency
    case swiftUI = "swiftui"
    case architecture
}

public struct ArchitectureLesson: Identifiable, Codable, Hashable {
    public let id: UUID
    public let title: String
    public let track: ArchitectureLessonTrack
    public let estimatedMinutes: Int
    public let isBookmarked: Bool

    public init(
        id: UUID,
        title: String,
        track: ArchitectureLessonTrack,
        estimatedMinutes: Int,
        isBookmarked: Bool = false
    ) {
        self.id = id
        self.title = title
        self.track = track
        self.estimatedMinutes = estimatedMinutes
        self.isBookmarked = isBookmarked
    }
}

public struct ArchitectureLessonFilter: Hashable {
    public var selectedTrack: ArchitectureLessonTrack?
    public var query: String
    public var bookmarksOnly: Bool

    public init(
        selectedTrack: ArchitectureLessonTrack? = nil,
        query: String = "",
        bookmarksOnly: Bool = false
    ) {
        self.selectedTrack = selectedTrack
        self.query = query
        self.bookmarksOnly = bookmarksOnly
    }
}

public struct WeeklyReviewSummary: Hashable {
    public let completedLessons: Int
    public let bookmarkedLessons: Int
    public let totalMinutes: Int

    public init(completedLessons: Int, bookmarkedLessons: Int, totalMinutes: Int) {
        self.completedLessons = completedLessons
        self.bookmarkedLessons = bookmarkedLessons
        self.totalMinutes = totalMinutes
    }
}

public enum SharedLessonDomain {
    public static func sampleLessons() -> [ArchitectureLesson] {
        [
            ArchitectureLesson(
                id: UUID(uuidString: "11111111-aaaa-bbbb-cccc-111111111111")!,
                title: "Constants and Variables",
                track: .foundations,
                estimatedMinutes: 15
            ),
            ArchitectureLesson(
                id: UUID(uuidString: "22222222-aaaa-bbbb-cccc-222222222222")!,
                title: "Value Semantics",
                track: .language,
                estimatedMinutes: 25,
                isBookmarked: true
            ),
            ArchitectureLesson(
                id: UUID(uuidString: "33333333-aaaa-bbbb-cccc-333333333333")!,
                title: "Task Groups",
                track: .concurrency,
                estimatedMinutes: 30
            ),
            ArchitectureLesson(
                id: UUID(uuidString: "44444444-aaaa-bbbb-cccc-444444444444")!,
                title: "NavigationStack",
                track: .swiftUI,
                estimatedMinutes: 35,
                isBookmarked: true
            ),
            ArchitectureLesson(
                id: UUID(uuidString: "55555555-aaaa-bbbb-cccc-555555555555")!,
                title: "Feature Store",
                track: .architecture,
                estimatedMinutes: 30
            ),
        ]
    }

    public static func filteredLessons(
        from lessons: [ArchitectureLesson],
        filter: ArchitectureLessonFilter
    ) -> [ArchitectureLesson] {
        lessons.filter { lesson in
            let trackMatch = filter.selectedTrack.map { lesson.track == $0 } ?? true
            let bookmarkMatch = filter.bookmarksOnly ? lesson.isBookmarked : true
            let normalizedQuery = filter.query.trimmingCharacters(in: .whitespacesAndNewlines)
            let queryMatch = normalizedQuery.isEmpty
                || lesson.title.localizedCaseInsensitiveContains(normalizedQuery)
                || lesson.track.rawValue.localizedCaseInsensitiveContains(normalizedQuery)
            return trackMatch && bookmarkMatch && queryMatch
        }
    }

    public static func weeklyReviewSummary(from lessons: [ArchitectureLesson]) -> WeeklyReviewSummary {
        WeeklyReviewSummary(
            completedLessons: max(lessons.count - 1, 0),
            bookmarkedLessons: lessons.filter(\.isBookmarked).count,
            totalMinutes: lessons.map(\.estimatedMinutes).reduce(0, +)
        )
    }
}
