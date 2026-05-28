import Foundation

enum LessonTrack: String, CaseIterable, Codable {
    case foundations
    case language
    case concurrency
    case swiftUI = "swiftui"
    case architecture
}

struct Lesson: Identifiable, Codable, Hashable {
    let id: UUID
    let title: String
    let track: LessonTrack
    let estimatedMinutes: Int
}

struct DashboardState {
    var lessons: [Lesson] = []
    var isLoading = false
    var selectedTrack: LessonTrack?
    var searchQuery = ""
    var bookmarkedLessonIDs: Set<UUID> = []
    var errorMessage: String?

    var visibleLessons: [Lesson] {
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

enum DashboardAction {
    case loadTapped
    case lessonsLoaded([Lesson])
    case failed(String)
    case searchChanged(String)
    case trackChanged(LessonTrack?)
    case bookmarksLoaded(Set<UUID>)
    case bookmarkToggled(UUID)
}

enum DashboardStoreError: Error {
    case loadFailed
    case saveFailed
}
