import Foundation
import XCTest
@testable import ArchitectureSharedDomain
@testable import MVVMSwiftUIApp

@MainActor
final class MVVMLessonListViewModelTests: XCTestCase {
    func testShowDetailAppendsRoute() {
        let lesson = SharedLessonDomain.sampleLessons()[0]
        let viewModel = MVVMLessonListViewModel()

        viewModel.showDetail(for: lesson)

        XCTAssertEqual(viewModel.path.count, 1)
        XCTAssertEqual(viewModel.path.first, .detail(lesson))
    }

    func testShowWeeklyReviewActivatesSheet() {
        let viewModel = MVVMLessonListViewModel()

        viewModel.showWeeklyReview()

        XCTAssertEqual(viewModel.activeSheet, .weeklyReview)
    }

    func testToggleBookmarkUpdatesActiveDetailRoute() {
        let lesson = SharedLessonDomain.sampleLessons()[1]
        let viewModel = MVVMLessonListViewModel()
        viewModel.showDetail(for: lesson)

        viewModel.toggleBookmark(for: lesson.id)

        guard case let .detail(updatedLesson)? = viewModel.path.first else {
            return XCTFail("Expected the active route to remain a detail route.")
        }

        XCTAssertEqual(updatedLesson.id, lesson.id)
        XCTAssertEqual(updatedLesson.isBookmarked, !lesson.isBookmarked)
    }

    func testBookmarksOnlyFilterReducesVisibleLessons() {
        let viewModel = MVVMLessonListViewModel()
        viewModel.filter.bookmarksOnly = true

        XCTAssertTrue(viewModel.visibleLessons.allSatisfy(\.isBookmarked))
        XCTAssertFalse(viewModel.visibleLessons.isEmpty)
    }

    func testTrackAndQueryFilterNarrowsVisibleLessons() {
        let viewModel = MVVMLessonListViewModel()
        viewModel.filter.selectedTrack = .swiftUI
        viewModel.filter.query = "navigation"

        let visibleTitles = viewModel.visibleLessons.map(\.title)

        XCTAssertEqual(visibleTitles, ["NavigationStack"])
    }
}
