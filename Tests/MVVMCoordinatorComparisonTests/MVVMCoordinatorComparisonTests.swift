import XCTest
@testable import ArchitectureSharedDomain
@testable import MVVMSwiftUIApp
@testable import CoordinatorMVVMApp

@MainActor
final class MVVMCoordinatorComparisonTests: XCTestCase {
    func testQueryFilteringMatchesBetweenMVVMAndCoordinator() {
        let mvvmViewModel = MVVMLessonListViewModel()
        let coordinator = LessonCoordinator()

        mvvmViewModel.filter.query = "task"
        coordinator.updateQuery("task")

        XCTAssertEqual(
            mvvmViewModel.visibleLessons.map(\.title),
            coordinator.visibleLessons.map(\.title)
        )
    }

    func testBookmarksOnlyFilteringMatchesBetweenMVVMAndCoordinator() {
        let mvvmViewModel = MVVMLessonListViewModel()
        let coordinator = LessonCoordinator()

        mvvmViewModel.filter.bookmarksOnly = true
        coordinator.updateBookmarksOnly(true)

        XCTAssertEqual(
            mvvmViewModel.visibleLessons.map(\.title),
            coordinator.visibleLessons.map(\.title)
        )
    }

    func testBookmarkToggleProducesMatchingDetailIntent() {
        let lesson = SharedLessonDomain.sampleLessons()[0]
        let mvvmViewModel = MVVMLessonListViewModel()
        let coordinator = LessonCoordinator()

        mvvmViewModel.showDetail(for: lesson)
        mvvmViewModel.toggleBookmark(for: lesson.id)

        coordinator.showDetail(for: lesson)
        coordinator.toggleBookmark(for: lesson.id)

        guard case let .detail(mvvmLesson)? = mvvmViewModel.path.first else {
            return XCTFail("Expected MVVM detail route to stay active.")
        }

        guard case let .detail(coordinatorLesson)? = coordinator.path.last else {
            return XCTFail("Expected coordinator detail route to stay active.")
        }

        XCTAssertEqual(mvvmLesson.title, coordinatorLesson.title)
        XCTAssertEqual(mvvmLesson.isBookmarked, coordinatorLesson.isBookmarked)
    }

    func testWeeklyReviewIntentMatchesBetweenMVVMAndCoordinator() {
        let mvvmViewModel = MVVMLessonListViewModel()
        let coordinator = LessonCoordinator()

        mvvmViewModel.showWeeklyReview()
        coordinator.showWeeklyReview()

        XCTAssertEqual(mvvmViewModel.activeSheet, .weeklyReview)
        XCTAssertEqual(coordinator.path.last, .weeklyReview)
    }
}
