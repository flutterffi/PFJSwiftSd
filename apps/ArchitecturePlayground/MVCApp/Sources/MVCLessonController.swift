import Foundation
#if canImport(ArchitectureSharedDomain)
import ArchitectureSharedDomain
#endif

struct MVCLessonRowViewState {
    let id: UUID
    let title: String
    let subtitle: String
    let isBookmarked: Bool
}

struct MVCLessonListViewState {
    let screenTitle: String
    let rows: [MVCLessonRowViewState]
    let bookmarkCountText: String
    let weeklySummaryText: String
}

struct MVCLessonDetailViewState {
    let title: String
    let metadata: String
    let detailSummary: String
    let bookmarkButtonTitle: String
}

final class MVCLessonRouter {
    private(set) var selectedLesson: ArchitectureLesson?

    func showDetail(for lesson: ArchitectureLesson) {
        selectedLesson = lesson
    }
}

final class MVCLessonController {
    private(set) var lessons: [ArchitectureLesson]
    private(set) var filter: ArchitectureLessonFilter
    let router: MVCLessonRouter

    var onListStateChange: ((MVCLessonListViewState) -> Void)?

    init(
        lessons: [ArchitectureLesson] = SharedLessonDomain.sampleLessons(),
        filter: ArchitectureLessonFilter = ArchitectureLessonFilter(),
        router: MVCLessonRouter = MVCLessonRouter()
    ) {
        self.lessons = lessons
        self.filter = filter
        self.router = router
    }

    var visibleLessons: [ArchitectureLesson] {
        SharedLessonDomain.filteredLessons(from: lessons, filter: filter)
    }

    var weeklySummary: WeeklyReviewSummary {
        SharedLessonDomain.weeklyReviewSummary(from: lessons)
    }

    func viewDidLoad() {
        renderList()
    }

    func updateQuery(_ query: String) {
        filter.query = query
        renderList()
    }

    func updateTrack(_ track: ArchitectureLessonTrack?) {
        filter.selectedTrack = track
        renderList()
    }

    func updateBookmarksOnly(_ enabled: Bool) {
        filter.bookmarksOnly = enabled
        renderList()
    }

    func toggleBookmark(for lessonID: UUID) {
        lessons = lessons.map { lesson in
            guard lesson.id == lessonID else {
                return lesson
            }

            return ArchitectureLesson(
                id: lesson.id,
                title: lesson.title,
                track: lesson.track,
                estimatedMinutes: lesson.estimatedMinutes,
                isBookmarked: !lesson.isBookmarked
            )
        }
        renderList()
    }

    func selectLesson(_ lessonID: UUID) {
        guard let lesson = lessons.first(where: { $0.id == lessonID }) else {
            return
        }
        router.showDetail(for: lesson)
    }

    func detailViewState(for lessonID: UUID) -> MVCLessonDetailViewState? {
        guard let lesson = lessons.first(where: { $0.id == lessonID }) else {
            return nil
        }

        return MVCLessonDetailViewState(
            title: lesson.title,
            metadata: "\(lesson.track.rawValue.uppercased()) · \(lesson.estimatedMinutes) min",
            detailSummary: "In MVC, the controller often owns filtering, bookmark updates, view preparation, and navigation decisions in one place.",
            bookmarkButtonTitle: lesson.isBookmarked ? "Remove Bookmark" : "Save Bookmark"
        )
    }

    private func renderList() {
        let rows = visibleLessons.map {
            MVCLessonRowViewState(
                id: $0.id,
                title: $0.title,
                subtitle: "\($0.track.rawValue.uppercased()) · \($0.estimatedMinutes) min",
                isBookmarked: $0.isBookmarked
            )
        }

        let state = MVCLessonListViewState(
            screenTitle: "MVC Comparison",
            rows: rows,
            bookmarkCountText: "\(lessons.filter(\.isBookmarked).count) bookmarked",
            weeklySummaryText: "\(weeklySummary.totalMinutes) total minutes this week"
        )

        onListStateChange?(state)
    }
}
