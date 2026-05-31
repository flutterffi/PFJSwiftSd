import Foundation
import XCTest
@testable import StudyDashboardFeatureCore

final class BookmarkPersistenceTests: XCTestCase {
    func testBookmarkPersistenceRoundtrip() throws {
        let tempDirectory = FileManager.default.temporaryDirectory
            .appendingPathComponent("pfjswiftsd-bookmark-tests", isDirectory: true)
        try? FileManager.default.removeItem(at: tempDirectory)
        try FileManager.default.createDirectory(at: tempDirectory, withIntermediateDirectories: true)
        defer {
            try? FileManager.default.removeItem(at: tempDirectory)
        }

        let fileURL = tempDirectory.appendingPathComponent("bookmarks.json")
        let persistence = BookmarkPersistence(fileURL: fileURL)
        let bookmarks: Set<UUID> = [
            UUID(uuidString: "aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa")!,
            UUID(uuidString: "bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb")!,
        ]

        try persistence.save(bookmarks)
        let loadedBookmarks = try persistence.load()

        XCTAssertEqual(loadedBookmarks, bookmarks)
    }
}
