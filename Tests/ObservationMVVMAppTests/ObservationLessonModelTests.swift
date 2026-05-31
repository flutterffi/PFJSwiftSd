import Foundation
import XCTest
@testable import ArchitectureSharedDomain
@testable import ObservationMVVMApp

final class ObservationLessonModelTests: XCTestCase {
    func testShowDetailAppendsRoute() {
        let lesson = SharedLessonDomain.sampleLessons()[0]
        let model = ObservationLessonModel()

        model.showDetail(for: lesson)

        XCTAssertEqual(model.path.count, 1)
        XCTAssertEqual(model.path.first, .detail(lesson))
    }

    func testShowBookmarksAppendsRoute() {
        let model = ObservationLessonModel()

        model.showBookmarks()

        XCTAssertEqual(model.path, [.bookmarks])
    }

    func testShowWeeklyReviewActivatesSheet() {
        let model = ObservationLessonModel()

        model.showWeeklyReview()

        XCTAssertEqual(model.activeSheet, .weeklyReview)
    }

    func testToggleBookmarkUpdatesActiveDetailRoute() {
        let lesson = SharedLessonDomain.sampleLessons()[1]
        let model = ObservationLessonModel()
        model.showDetail(for: lesson)

        model.toggleBookmark(for: lesson.id)

        guard case let .detail(updatedLesson)? = model.path.first else {
            return XCTFail("Expected the active route to remain a detail route.")
        }

        XCTAssertEqual(updatedLesson.id, lesson.id)
        XCTAssertEqual(updatedLesson.isBookmarked, !lesson.isBookmarked)
    }

    func testBookmarksOnlyFilterReducesVisibleLessons() {
        let model = ObservationLessonModel()
        model.filter.bookmarksOnly = true

        XCTAssertTrue(model.visibleLessons.allSatisfy(\.isBookmarked))
        XCTAssertFalse(model.visibleLessons.isEmpty)
    }

    func testTrackAndQueryFilterNarrowsVisibleLessons() {
        let model = ObservationLessonModel()
        model.filter.selectedTrack = .swiftUI
        model.filter.query = "navigation"

        let visibleTitles = model.visibleLessons.map(\.title)

        XCTAssertEqual(visibleTitles, ["NavigationStack"])
    }

    func testFailingServiceShowsLoadError() {
        let model = ObservationLessonModel(service: FailingObservationLessonService())

        XCTAssertEqual(model.errorMessage, "Unable to load saved bookmarks.")
        XCTAssertFalse(model.lessons.isEmpty)
    }

    func testFailingServiceShowsSaveError() {
        let lesson = SharedLessonDomain.sampleLessons()[0]
        let model = ObservationLessonModel(service: FailingObservationLessonService())
        model.dismissError()

        model.toggleBookmark(for: lesson.id)

        XCTAssertEqual(model.errorMessage, "Unable to save bookmarks.")
    }
}

private struct FailingObservationLessonService: ObservationLessonService {
    func loadLessons() throws -> [ArchitectureLesson] {
        throw ObservationTestError.loadFailed
    }

    func toggleBookmark(in lessons: [ArchitectureLesson], lessonID: UUID) throws -> [ArchitectureLesson] {
        throw ObservationTestError.saveFailed
    }
}

private enum ObservationTestError: Error {
    case loadFailed
    case saveFailed
}
