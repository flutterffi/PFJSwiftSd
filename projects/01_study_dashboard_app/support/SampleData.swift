import Foundation

public func makeSampleLessons() -> [Lesson] {
    [
        Lesson(id: UUID(uuidString: "11111111-1111-1111-1111-111111111111")!, title: "Constants and Variables", track: .foundations, estimatedMinutes: 15),
        Lesson(id: UUID(uuidString: "22222222-2222-2222-2222-222222222222")!, title: "Optionals and Guard", track: .foundations, estimatedMinutes: 20),
        Lesson(id: UUID(uuidString: "33333333-3333-3333-3333-333333333333")!, title: "Value Semantics", track: .language, estimatedMinutes: 25),
        Lesson(id: UUID(uuidString: "44444444-4444-4444-4444-444444444444")!, title: "Task Groups", track: .concurrency, estimatedMinutes: 30),
        Lesson(id: UUID(uuidString: "55555555-5555-5555-5555-555555555555")!, title: "NavigationStack", track: .swiftUI, estimatedMinutes: 35),
        Lesson(id: UUID(uuidString: "66666666-6666-6666-6666-666666666666")!, title: "Feature Store", track: .architecture, estimatedMinutes: 30),
    ]
}

public func makeDashboardEnvironment(bookmarksFileURL: URL) -> DashboardEnvironment {
    let persistence = BookmarkPersistence(fileURL: bookmarksFileURL)

    return DashboardEnvironment(
        fetchLessons: {
            try await Task.sleep(nanoseconds: 150_000_000)
            return makeSampleLessons()
        },
        loadBookmarks: {
            try persistence.load()
        },
        saveBookmarks: { bookmarks in
            try persistence.save(bookmarks)
        }
    )
}
