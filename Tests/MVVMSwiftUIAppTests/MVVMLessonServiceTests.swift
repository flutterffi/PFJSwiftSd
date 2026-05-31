import Foundation
import XCTest
@testable import ArchitectureSharedDomain
@testable import MVVMSwiftUIApp

final class MVVMLessonServiceTests: XCTestCase {
    func testLoadLessonsReturnsSharedSampleData() throws {
        let service = InMemoryMVVMLessonService()

        let lessons = try service.loadLessons()

        XCTAssertEqual(lessons.count, SharedLessonDomain.sampleLessons().count)
        XCTAssertEqual(lessons.first?.title, "Constants and Variables")
    }

    func testToggleBookmarkUpdatesOnlyMatchingLesson() throws {
        let service = InMemoryMVVMLessonService()
        let lessons = SharedLessonDomain.sampleLessons()
        let targetID = lessons[1].id

        let updatedLessons = try service.toggleBookmark(in: lessons, lessonID: targetID)

        XCTAssertEqual(updatedLessons.count, lessons.count)
        XCTAssertEqual(updatedLessons[1].isBookmarked, !lessons[1].isBookmarked)
        XCTAssertEqual(updatedLessons[0].isBookmarked, lessons[0].isBookmarked)
        XCTAssertEqual(updatedLessons[2].isBookmarked, lessons[2].isBookmarked)
    }

    func testPersistedServiceLoadsSavedBookmarks() throws {
        let tempDirectory = FileManager.default.temporaryDirectory
            .appendingPathComponent("pfjswiftsd-mvvm-service-tests", isDirectory: true)
        try? FileManager.default.removeItem(at: tempDirectory)
        try FileManager.default.createDirectory(at: tempDirectory, withIntermediateDirectories: true)
        defer {
            try? FileManager.default.removeItem(at: tempDirectory)
        }

        let fileURL = tempDirectory.appendingPathComponent("bookmarks.json")
        let persistence = MVVMBookmarkPersistence(fileURL: fileURL)
        let lessons = SharedLessonDomain.sampleLessons()
        let targetID = lessons[0].id
        try persistence.save([targetID])

        let service = PersistedMVVMLessonService(persistence: persistence)
        let loadedLessons = try service.loadLessons()

        XCTAssertTrue(loadedLessons.contains(where: { $0.id == targetID && $0.isBookmarked }))
    }
}
