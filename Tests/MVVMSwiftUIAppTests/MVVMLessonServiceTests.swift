import Foundation
import XCTest
@testable import ArchitectureSharedDomain
@testable import MVVMSwiftUIApp

final class MVVMLessonServiceTests: XCTestCase {
    func testLoadLessonsReturnsSharedSampleData() {
        let service = InMemoryMVVMLessonService()

        let lessons = service.loadLessons()

        XCTAssertEqual(lessons.count, SharedLessonDomain.sampleLessons().count)
        XCTAssertEqual(lessons.first?.title, "Constants and Variables")
    }

    func testToggleBookmarkUpdatesOnlyMatchingLesson() {
        let service = InMemoryMVVMLessonService()
        let lessons = SharedLessonDomain.sampleLessons()
        let targetID = lessons[1].id

        let updatedLessons = service.toggleBookmark(in: lessons, lessonID: targetID)

        XCTAssertEqual(updatedLessons.count, lessons.count)
        XCTAssertEqual(updatedLessons[1].isBookmarked, !lessons[1].isBookmarked)
        XCTAssertEqual(updatedLessons[0].isBookmarked, lessons[0].isBookmarked)
        XCTAssertEqual(updatedLessons[2].isBookmarked, lessons[2].isBookmarked)
    }
}
