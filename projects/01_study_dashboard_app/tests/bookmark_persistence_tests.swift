import Foundation

func assert(_ condition: @autoclosure () -> Bool, _ message: String) {
    if condition() {
        print("PASS:", message)
    } else {
        print("FAIL:", message)
        Foundation.exit(1)
    }
}

@main
struct BookmarkPersistenceTests {
    static func main() throws {
        let tempDirectory = FileManager.default.temporaryDirectory
            .appendingPathComponent("pfjswiftsd-bookmark-tests", isDirectory: true)
        try? FileManager.default.removeItem(at: tempDirectory)
        try FileManager.default.createDirectory(at: tempDirectory, withIntermediateDirectories: true)

        let fileURL = tempDirectory.appendingPathComponent("bookmarks.json")
        let persistence = BookmarkPersistence(fileURL: fileURL)
        let bookmarks: Set<UUID> = [
            UUID(uuidString: "aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa")!,
            UUID(uuidString: "bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb")!,
        ]

        try persistence.save(bookmarks)
        let loadedBookmarks = try persistence.load()

        assert(loadedBookmarks == bookmarks, "bookmark persistence roundtrip keeps the same values")

        try FileManager.default.removeItem(at: tempDirectory)
        print("All bookmark persistence tests passed.")
    }
}
