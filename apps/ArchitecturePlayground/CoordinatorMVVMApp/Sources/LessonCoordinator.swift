import Foundation
#if canImport(ArchitectureSharedDomain)
import ArchitectureSharedDomain
#endif

enum LessonRoute: Hashable {
    case list
    case detail(ArchitectureLesson)
    case weeklyReview
}

struct CoordinatorLessonRowViewState {
    let id: UUID
    let title: String
    let subtitle: String
    let isBookmarked: Bool
}

struct CoordinatorLessonListViewState {
    let title: String
    let rows: [CoordinatorLessonRowViewState]
    let bookmarkCountText: String
    let weeklySummaryText: String
}

struct CoordinatorLessonDetailViewState {
    let title: String
    let metadata: String
    let detailSummary: String
    let bookmarkButtonTitle: String
}

struct CoordinatorWeeklyReviewViewState {
    let title: String
    let summaryText: String
}

final class LessonCoordinator {
    private(set) var path: [LessonRoute] = []
    private(set) var lessons: [ArchitectureLesson] = SharedLessonDomain.sampleLessons()
    private(set) var filter = ArchitectureLessonFilter()

    var visibleLessons: [ArchitectureLesson] {
        SharedLessonDomain.filteredLessons(from: lessons, filter: filter)
    }

    var weeklySummary: WeeklyReviewSummary {
        SharedLessonDomain.weeklyReviewSummary(from: lessons)
    }

    func listViewState() -> CoordinatorLessonListViewState {
        let rows = visibleLessons.map {
            CoordinatorLessonRowViewState(
                id: $0.id,
                title: $0.title,
                subtitle: "\($0.track.rawValue.uppercased()) · \($0.estimatedMinutes) min",
                isBookmarked: $0.isBookmarked
            )
        }

        return CoordinatorLessonListViewState(
            title: "Coordinator Comparison",
            rows: rows,
            bookmarkCountText: "\(lessons.filter(\.isBookmarked).count) bookmarked",
            weeklySummaryText: "\(weeklySummary.totalMinutes) total minutes this week"
        )
    }

    func updateQuery(_ query: String) {
        filter.query = query
    }

    func updateTrack(_ track: ArchitectureLessonTrack?) {
        filter.selectedTrack = track
    }

    func updateBookmarksOnly(_ enabled: Bool) {
        filter.bookmarksOnly = enabled
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
        if case let .detail(lesson)? = path.last, lesson.id == lessonID,
           let updated = lessons.first(where: { $0.id == lessonID }) {
            path.removeLast()
            path.append(.detail(updated))
        }
    }

    func showDetail(for lesson: ArchitectureLesson) {
        path.append(.detail(lesson))
    }

    func showWeeklyReview() {
        path.append(.weeklyReview)
    }

    func detailViewState(for lesson: ArchitectureLesson) -> CoordinatorLessonDetailViewState {
        CoordinatorLessonDetailViewState(
            title: lesson.title,
            metadata: "\(lesson.track.rawValue.uppercased()) · \(lesson.estimatedMinutes) min",
            detailSummary: "Coordinator-oriented MVVM moves route decisions into a central navigation object so views and view models do less direct navigation work.",
            bookmarkButtonTitle: lesson.isBookmarked ? "Remove Bookmark" : "Save Bookmark"
        )
    }

    func weeklyReviewViewState() -> CoordinatorWeeklyReviewViewState {
        CoordinatorWeeklyReviewViewState(
            title: "Weekly Review",
            summaryText: "\(weeklySummary.bookmarkedLessons) bookmarked lessons across \(weeklySummary.totalMinutes) minutes of planned study."
        )
    }

    func reset() {
        path = []
    }
}
