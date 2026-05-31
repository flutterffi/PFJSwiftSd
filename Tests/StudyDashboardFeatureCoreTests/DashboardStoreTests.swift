import Foundation
import XCTest
@testable import StudyDashboardFeatureCore

final class DashboardStoreTests: XCTestCase {
    func testLoadAndSearch() async {
        var store = DashboardStore(environment: makeInMemoryEnvironment())
        await store.send(.loadTapped)

        XCTAssertEqual(store.state.lessons.count, 6)

        await store.send(.searchChanged("task"))
        XCTAssertEqual(store.state.visibleLessons.count, 1)
        XCTAssertEqual(store.state.visibleLessons.first?.title, "Task Groups")
    }

    func testTrackFiltering() async {
        var store = DashboardStore(environment: makeInMemoryEnvironment())
        await store.send(.loadTapped)
        await store.send(.trackChanged(.swiftUI))

        XCTAssertEqual(store.state.visibleLessons.count, 1)
        XCTAssertEqual(store.state.visibleLessons.first?.track, .swiftUI)
    }

    func testBookmarkTogglePersistsState() async {
        let lessonID = makeSampleLessons()[4].id
        let recorder = SavedBookmarksRecorder()

        var store = DashboardStore(
            environment: makeInMemoryEnvironment(
                saveHandler: { bookmarks in
                    await recorder.record(bookmarks)
                }
            )
        )

        await store.send(.loadTapped)
        await store.send(.bookmarkToggled(lessonID))

        XCTAssertTrue(store.state.bookmarkedLessonIDs.contains(lessonID))
        let savedBookmarks = await recorder.bookmarks
        XCTAssertTrue(savedBookmarks.contains(lessonID))
    }

    func testLoadFailureSetsErrorMessage() async {
        let environment = DashboardEnvironment(
            fetchLessons: {
                throw DashboardStoreError.loadFailed
            },
            loadBookmarks: {
                []
            },
            saveBookmarks: { _ in }
        )

        var store = DashboardStore(environment: environment)
        await store.send(.loadTapped)

        XCTAssertFalse(store.state.isLoading)
        XCTAssertEqual(store.state.errorMessage, "Unable to load dashboard data")
    }

    func testSaveFailureKeepsOptimisticStateAndSetsError() async {
        let lessonID = makeSampleLessons()[4].id
        let environment = DashboardEnvironment(
            fetchLessons: {
                makeSampleLessons()
            },
            loadBookmarks: {
                []
            },
            saveBookmarks: { _ in
                throw DashboardStoreError.saveFailed
            }
        )

        var store = DashboardStore(environment: environment)
        await store.send(.loadTapped)
        await store.send(.bookmarkToggled(lessonID))

        XCTAssertTrue(store.state.bookmarkedLessonIDs.contains(lessonID))
        XCTAssertEqual(store.state.errorMessage, "Unable to save bookmarks")
    }
}

private func makeInMemoryEnvironment(
    lessons: [Lesson] = makeSampleLessons(),
    initialBookmarks: Set<UUID> = [],
    saveHandler: @escaping @Sendable (Set<UUID>) async throws -> Void = { _ in }
) -> DashboardEnvironment {
    DashboardEnvironment(
        fetchLessons: {
            lessons
        },
        loadBookmarks: {
            initialBookmarks
        },
        saveBookmarks: { bookmarks in
            try await saveHandler(bookmarks)
        }
    )
}

private actor SavedBookmarksRecorder {
    private(set) var bookmarks: Set<UUID> = []

    func record(_ bookmarks: Set<UUID>) {
        self.bookmarks = bookmarks
    }
}
