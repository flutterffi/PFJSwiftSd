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

    func testShowBookmarksAppendsRoute() {
        let viewModel = MVVMLessonListViewModel()

        viewModel.showBookmarks()

        XCTAssertEqual(viewModel.path, [.bookmarks])
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

    func testFailingServiceShowsLoadError() {
        let viewModel = MVVMLessonListViewModel(service: FailingMVVMLessonService())

        XCTAssertEqual(viewModel.errorMessage, "Unable to load saved bookmarks.")
        XCTAssertFalse(viewModel.lessons.isEmpty)
    }

    func testFailingServiceShowsSaveError() {
        let lesson = SharedLessonDomain.sampleLessons()[0]
        let viewModel = MVVMLessonListViewModel(service: FailingMVVMLessonService())
        viewModel.dismissError()

        viewModel.toggleBookmark(for: lesson.id)

        XCTAssertEqual(viewModel.errorMessage, "Unable to save bookmarks.")
    }
}

private struct FailingMVVMLessonService: MVVMLessonService {
    func loadLessons() throws -> [ArchitectureLesson] {
        throw MVVMTestError.loadFailed
    }

    func toggleBookmark(in lessons: [ArchitectureLesson], lessonID: UUID) throws -> [ArchitectureLesson] {
        throw MVVMTestError.saveFailed
    }
}

private enum MVVMTestError: Error {
    case loadFailed
    case saveFailed
}
