import Foundation
#if canImport(ArchitectureSharedDomain)
import ArchitectureSharedDomain
#endif

struct UIKitLessonRowModel {
    let id: UUID
    let title: String
    let subtitle: String
    let isBookmarked: Bool
}

struct UIKitLessonListViewState {
    let title: String
    let rows: [UIKitLessonRowModel]
    let bookmarkCountText: String
    let weeklySummaryText: String
}

struct UIKitLessonDetailViewState {
    let title: String
    let metadata: String
    let detailSummary: String
    let bookmarkButtonTitle: String
}

final class UIKitLessonViewModel {
    var onStateChange: ((UIKitLessonListViewState) -> Void)?

    private var lessons: [ArchitectureLesson] = SharedLessonDomain.sampleLessons()
    private var filter = ArchitectureLessonFilter()
    private(set) var selectedLesson: ArchitectureLesson?

    func load() {
        publish()
    }

    func updateQuery(_ query: String) {
        filter.query = query
        publish()
    }

    func updateTrack(_ track: ArchitectureLessonTrack?) {
        filter.selectedTrack = track
        publish()
    }

    func updateBookmarksOnly(_ enabled: Bool) {
        filter.bookmarksOnly = enabled
        publish()
    }

    func toggleBookmark(for lessonID: UUID) {
        lessons = lessons.map { lesson in
            guard lesson.id == lessonID else { return lesson }
            return ArchitectureLesson(
                id: lesson.id,
                title: lesson.title,
                track: lesson.track,
                estimatedMinutes: lesson.estimatedMinutes,
                isBookmarked: !lesson.isBookmarked
            )
        }
        if let selectedLesson, selectedLesson.id == lessonID {
            self.selectedLesson = lessons.first(where: { $0.id == lessonID })
        }
        publish()
    }

    func selectLesson(_ lessonID: UUID) {
        selectedLesson = lessons.first(where: { $0.id == lessonID })
    }

    func detailViewState() -> UIKitLessonDetailViewState? {
        guard let lesson = selectedLesson else {
            return nil
        }

        return UIKitLessonDetailViewState(
            title: lesson.title,
            metadata: "\(lesson.track.rawValue.uppercased()) · \(lesson.estimatedMinutes) min",
            detailSummary: "UIKit-style MVVM keeps formatting and interaction state inside the view model while the view controller stays more focused on binding and lifecycle.",
            bookmarkButtonTitle: lesson.isBookmarked ? "Remove Bookmark" : "Save Bookmark"
        )
    }

    private func publish() {
        let visibleLessons = SharedLessonDomain.filteredLessons(from: lessons, filter: filter)
        let weeklySummary = SharedLessonDomain.weeklyReviewSummary(from: lessons)
        let rows = visibleLessons.map {
            UIKitLessonRowModel(
                id: $0.id,
                title: $0.title,
                subtitle: "\($0.track.rawValue.uppercased()) · \($0.estimatedMinutes) min",
                isBookmarked: $0.isBookmarked
            )
        }
        let viewState = UIKitLessonListViewState(
            title: "UIKit MVVM Comparison",
            rows: rows,
            bookmarkCountText: "\(lessons.filter(\.isBookmarked).count) bookmarked",
            weeklySummaryText: "\(weeklySummary.totalMinutes) total minutes this week"
        )
        onStateChange?(viewState)
    }
}
