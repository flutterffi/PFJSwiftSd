import XCTest
@testable import ArchitectureSharedDomain
@testable import CoordinatorMVVMApp

final class LessonCoordinatorTests: XCTestCase {
    func testQueryFilteringShapesListViewState() {
        let coordinator = LessonCoordinator()

        coordinator.updateQuery("task")
        let state = coordinator.listViewState()

        XCTAssertEqual(state.rows.count, 1)
        XCTAssertEqual(state.rows.first?.title, "Task Groups")
    }

    func testBookmarkToggleKeepsDetailRouteInSync() {
        let coordinator = LessonCoordinator()
        let lesson = SharedLessonDomain.sampleLessons()[0]

        coordinator.showDetail(for: lesson)
        coordinator.toggleBookmark(for: lesson.id)

        guard case let .detail(updatedLesson)? = coordinator.path.last else {
            return XCTFail("Expected detail route to stay active.")
        }

        XCTAssertEqual(updatedLesson.id, lesson.id)
        XCTAssertEqual(updatedLesson.isBookmarked, true)
        XCTAssertEqual(
            coordinator.detailViewState(for: updatedLesson).bookmarkButtonTitle,
            "Remove Bookmark"
        )
    }

    func testWeeklyReviewRouteAndViewState() {
        let coordinator = LessonCoordinator()

        coordinator.showWeeklyReview()

        XCTAssertEqual(coordinator.path.last, .weeklyReview)
        XCTAssertEqual(coordinator.weeklyReviewViewState().title, "Weekly Review")
    }
}
