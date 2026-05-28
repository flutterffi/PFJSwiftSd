import Foundation

public struct BookmarkPersistence {
    public let fileURL: URL

    public init(fileURL: URL) {
        self.fileURL = fileURL
    }

    public func load() throws -> Set<UUID> {
        guard FileManager.default.fileExists(atPath: fileURL.path) else {
            return []
        }

        let data = try Data(contentsOf: fileURL)
        let values = try JSONDecoder().decode([UUID].self, from: data)
        return Set(values)
    }

    public func save(_ bookmarks: Set<UUID>) throws {
        let sorted = bookmarks
            .map(\.uuidString)
            .sorted()
            .compactMap(UUID.init(uuidString:))
        let data = try JSONEncoder().encode(sorted)
        try data.write(to: fileURL, options: .atomic)
    }
}
