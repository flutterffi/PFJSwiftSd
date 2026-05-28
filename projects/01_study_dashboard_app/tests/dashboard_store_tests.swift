import Foundation

func assert(_ condition: @autoclosure () -> Bool, _ message: String) {
    if condition() {
        print("PASS:", message)
    } else {
        print("FAIL:", message)
        Foundation.exit(1)
    }
}

func makeInMemoryEnvironment(
    lessons: [Lesson] = makeSampleLessons(),
    initialBookmarks: Set<UUID> = [],
    saveHandler: @escaping (Set<UUID>) throws -> Void = { _ in }
) -> DashboardEnvironment {
    DashboardEnvironment(
        fetchLessons: {
            lessons
        },
        loadBookmarks: {
            initialBookmarks
        },
        saveBookmarks: saveHandler
    )
}

@main
struct DashboardStoreTests {
    static func main() async {
        await testLoadAndSearch()
        await testTrackFiltering()
        await testBookmarkToggle()
        await testLoadFailure()
        await testSaveFailure()
        print("All dashboard store tests passed.")
    }

    static func testLoadAndSearch() async {
        var store = DashboardStore(environment: makeInMemoryEnvironment())
        await store.send(.loadTapped)

        assert(store.state.lessons.count == 6, "load populates all lessons")

        await store.send(.searchChanged("task"))
        assert(store.state.visibleLessons.count == 1, "search narrows visible lessons")
        assert(store.state.visibleLessons.first?.title == "Task Groups", "search returns the expected lesson")
    }

    static func testTrackFiltering() async {
        var store = DashboardStore(environment: makeInMemoryEnvironment())
        await store.send(.loadTapped)
        await store.send(.trackChanged(.swiftUI))

        assert(store.state.visibleLessons.count == 1, "track filter narrows visible lessons")
        assert(store.state.visibleLessons.first?.track == .swiftUI, "track filter keeps the selected track")
    }

    static func testBookmarkToggle() async {
        let lessonID = makeSampleLessons()[4].id
        var savedBookmarks: Set<UUID> = []

        var store = DashboardStore(
            environment: makeInMemoryEnvironment(
                saveHandler: { bookmarks in
                    savedBookmarks = bookmarks
                }
            )
        )

        await store.send(.loadTapped)
        await store.send(.bookmarkToggled(lessonID))

        assert(store.state.bookmarkedLessonIDs.contains(lessonID), "bookmark toggle updates store state")
        assert(savedBookmarks.contains(lessonID), "bookmark toggle persists bookmarks")
    }

    static func testLoadFailure() async {
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

        assert(store.state.isLoading == false, "load failure clears loading state")
        assert(store.state.errorMessage == "Unable to load dashboard data", "load failure exposes an error message")
    }

    static func testSaveFailure() async {
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

        assert(store.state.bookmarkedLessonIDs.contains(lessonID), "save failure keeps optimistic bookmark state")
        assert(store.state.errorMessage == "Unable to save bookmarks", "save failure exposes an error message")
    }
}
