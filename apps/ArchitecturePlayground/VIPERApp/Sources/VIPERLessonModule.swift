import Foundation
#if canImport(ArchitectureSharedDomain)
import ArchitectureSharedDomain
#endif

protocol VIPERLessonView: AnyObject {
    func render(_ model: VIPERLessonListViewModel)
}

protocol VIPERLessonRouting {
    func routeToDetail(for lesson: ArchitectureLesson)
}

struct VIPERLessonRowViewModel {
    let id: UUID
    let title: String
    let subtitle: String
    let isBookmarked: Bool
}

struct VIPERLessonListViewModel {
    let title: String
    let rows: [VIPERLessonRowViewModel]
    let bookmarkCountText: String
    let weeklySummaryText: String
}

struct VIPERLessonDetailViewModel {
    let title: String
    let metadata: String
    let detailSummary: String
    let bookmarkButtonTitle: String
}

struct VIPERLessonInteractor {
    var lessons: [ArchitectureLesson] = SharedLessonDomain.sampleLessons()

    func filteredLessons(using filter: ArchitectureLessonFilter) -> [ArchitectureLesson] {
        SharedLessonDomain.filteredLessons(from: lessons, filter: filter)
    }

    func weeklySummary() -> WeeklyReviewSummary {
        SharedLessonDomain.weeklyReviewSummary(from: lessons)
    }
}

final class VIPERLessonPresenter {
    weak var view: VIPERLessonView?
    var router: VIPERLessonRouting?
    var interactor = VIPERLessonInteractor()
    var filter = ArchitectureLessonFilter()

    func load() {
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

    func selectLesson(_ lesson: ArchitectureLesson) {
        router?.routeToDetail(for: lesson)
    }

    func detailViewModel(for lessonID: UUID) -> VIPERLessonDetailViewModel? {
        guard let lesson = interactor.lessons.first(where: { $0.id == lessonID }) else {
            return nil
        }

        return VIPERLessonDetailViewModel(
            title: lesson.title,
            metadata: "\(lesson.track.rawValue.uppercased()) · \(lesson.estimatedMinutes) min",
            detailSummary: "In VIPER, routing, formatting, and interaction boundaries are more explicit, but assembly and coordination overhead also rise.",
            bookmarkButtonTitle: lesson.isBookmarked ? "Remove Bookmark" : "Save Bookmark"
        )
    }

    private func render() {
        let visibleLessons = interactor.filteredLessons(using: filter)
        let rows = visibleLessons.map {
            VIPERLessonRowViewModel(
                id: $0.id,
                title: $0.title,
                subtitle: "\($0.track.rawValue.uppercased()) · \($0.estimatedMinutes) min",
                isBookmarked: $0.isBookmarked
            )
        }
        let summary = interactor.weeklySummary()
        let model = VIPERLessonListViewModel(
            title: "VIPER Comparison",
            rows: rows,
            bookmarkCountText: "\(interactor.lessons.filter(\.isBookmarked).count) bookmarked",
            weeklySummaryText: "\(summary.totalMinutes) total minutes this week"
        )
        view?.render(model)
    }
}

enum VIPERLessonModuleBuilder {
    static func build() -> VIPERLessonPresenter {
        VIPERLessonPresenter()
    }
}
