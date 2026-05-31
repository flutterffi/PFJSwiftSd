import Foundation

struct MVVMBookmarkPersistence: Sendable {
    let fileURL: URL

    func load() throws -> Set<UUID> {
        guard FileManager.default.fileExists(atPath: fileURL.path) else {
            return []
        }

        let data = try Data(contentsOf: fileURL)
        let values = try JSONDecoder().decode([UUID].self, from: data)
        return Set(values)
    }

    func save(_ bookmarks: Set<UUID>) throws {
        let sorted = bookmarks
            .map(\.uuidString)
            .sorted()
            .compactMap(UUID.init(uuidString:))
        let data = try JSONEncoder().encode(sorted)

        let directory = fileURL.deletingLastPathComponent()
        try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)
        try data.write(to: fileURL, options: .atomic)
    }
}
