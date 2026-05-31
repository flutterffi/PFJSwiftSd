import Foundation
#if canImport(ArchitectureSharedDomain)
import ArchitectureSharedDomain
#endif

@MainActor
final class MVVMLessonListViewModel: ObservableObject {
    @Published private(set) var lessons: [ArchitectureLesson]
    @Published var filter = ArchitectureLessonFilter()
    @Published var path: [MVVMRoute] = []
    @Published var activeSheet: MVVMSheetRoute?
    @Published var errorMessage: String?

    private let service: MVVMLessonService

    init(service: MVVMLessonService = InMemoryMVVMLessonService()) {
        self.service = service
        do {
            self.lessons = try service.loadLessons()
        } catch {
            self.lessons = SharedLessonDomain.sampleLessons()
            self.errorMessage = "Unable to load saved bookmarks."
        }
    }

    var visibleLessons: [ArchitectureLesson] {
        SharedLessonDomain.filteredLessons(from: lessons, filter: filter)
    }

    var bookmarkedLessons: [ArchitectureLesson] {
        lessons.filter(\.isBookmarked)
    }

    var weeklySummary: WeeklyReviewSummary {
        SharedLessonDomain.weeklyReviewSummary(from: lessons)
    }

    func toggleBookmark(for lessonID: UUID) {
        do {
            lessons = try service.toggleBookmark(in: lessons, lessonID: lessonID)
            syncActiveDetailRoute(for: lessonID)
        } catch {
            errorMessage = "Unable to save bookmarks."
        }
    }

    func showBookmarks() {
        path.append(.bookmarks)
    }

    func showDetail(for lesson: ArchitectureLesson) {
        path.append(.detail(lesson))
    }

    func showWeeklyReview() {
        activeSheet = .weeklyReview
    }

    func dismissError() {
        errorMessage = nil
    }

    private func syncActiveDetailRoute(for lessonID: UUID) {
        guard let index = path.lastIndex(where: {
            if case let .detail(lesson) = $0 {
                return lesson.id == lessonID
            }
            return false
        }), let updated = lessons.first(where: { $0.id == lessonID }) else {
            return
        }

        path[index] = .detail(updated)
    }
}
