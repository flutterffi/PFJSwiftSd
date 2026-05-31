import Foundation
#if canImport(ArchitectureSharedDomain)
import ArchitectureSharedDomain
#endif

protocol MVPLessonView: AnyObject {
    func renderList(_ model: MVPLessonListViewModel)
}

struct MVPLessonRowViewModel {
    let id: UUID
    let title: String
    let subtitle: String
    let isBookmarked: Bool
}

struct MVPLessonListViewModel {
    let title: String
    let rows: [MVPLessonRowViewModel]
    let bookmarkCountText: String
    let weeklySummaryText: String
}

struct MVPLessonDetailViewModel {
    let title: String
    let metadata: String
    let detailSummary: String
    let bookmarkButtonTitle: String
}

protocol MVPLessonRouting: AnyObject {
    func routeToDetail(for lesson: ArchitectureLesson)
}

struct MVPLessonInteractor {
    var lessons: [ArchitectureLesson] = SharedLessonDomain.sampleLessons()

    func filteredLessons(using filter: ArchitectureLessonFilter) -> [ArchitectureLesson] {
        SharedLessonDomain.filteredLessons(from: lessons, filter: filter)
    }

    func weeklySummary() -> WeeklyReviewSummary {
        SharedLessonDomain.weeklyReviewSummary(from: lessons)
    }
}

final class MVPLessonPresenter {
    weak var view: MVPLessonView?
    weak var router: MVPLessonRouting?
    private var interactor: MVPLessonInteractor
    private var filter = ArchitectureLessonFilter()

    init(
        view: MVPLessonView? = nil,
        router: MVPLessonRouting? = nil,
        interactor: MVPLessonInteractor = MVPLessonInteractor()
    ) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }

    func viewDidLoad() {
        render()
    }

    func updateQuery(_ query: String) {
        filter.query = query
        render()
    }

    func updateTrack(_ track: ArchitectureLessonTrack?) {
        filter.selectedTrack = track
        render()
    }

    func updateBookmarksOnly(_ enabled: Bool) {
        filter.bookmarksOnly = enabled
        render()
    }

    func toggleBookmark(for lessonID: UUID) {
        interactor.lessons = interactor.lessons.map { lesson in
            guard lesson.id == lessonID else { return lesson }
            return ArchitectureLesson(
                id: lesson.id,
                title: lesson.title,
                track: lesson.track,
                estimatedMinutes: lesson.estimatedMinutes,
                isBookmarked: !lesson.isBookmarked
            )
        }
        render()
    }

    func selectLesson(_ lessonID: UUID) {
        guard let lesson = interactor.lessons.first(where: { $0.id == lessonID }) else {
            return
        }
        router?.routeToDetail(for: lesson)
    }

    func detailViewModel(for lessonID: UUID) -> MVPLessonDetailViewModel? {
        guard let lesson = interactor.lessons.first(where: { $0.id == lessonID }) else {
            return nil
        }

        return MVPLessonDetailViewModel(
            title: lesson.title,
            metadata: "\(lesson.track.rawValue.uppercased()) · \(lesson.estimatedMinutes) min",
            detailSummary: "In MVP, the presenter drives formatting and interaction flow while the view stays more passive than in MVC.",
            bookmarkButtonTitle: lesson.isBookmarked ? "Remove Bookmark" : "Save Bookmark"
        )
    }

    private func render() {
        let visibleLessons = interactor.filteredLessons(using: filter)
        let rows = visibleLessons.map {
            MVPLessonRowViewModel(
                id: $0.id,
                title: $0.title,
                subtitle: "\($0.track.rawValue.uppercased()) · \($0.estimatedMinutes) min",
                isBookmarked: $0.isBookmarked
            )
        }

        let summary = interactor.weeklySummary()
        let model = MVPLessonListViewModel(
            title: "MVP Comparison",
            rows: rows,
            bookmarkCountText: "\(interactor.lessons.filter(\.isBookmarked).count) bookmarked",
            weeklySummaryText: "\(summary.totalMinutes) total minutes this week"
        )
        view?.renderList(model)
    }
}
