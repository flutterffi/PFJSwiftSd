import XCTest
@testable import ReducerStyleApp
@testable import ArchitectureSharedDomain

final class ReducerLessonStoreTests: XCTestCase {
    func testQueryFilteringPublishesExpectedRows() {
        let store = ReducerLessonStore()
        var latestState: ReducerLessonListViewState?
        store.onListStateChange = { latestState = $0 }

        store.send(.viewDidLoad)
        store.send(.updateQuery("task"))

        XCTAssertEqual(latestState?.rows.count, 1)
        XCTAssertEqual(latestState?.rows.first?.title, "Task Groups")
    }

    func testBookmarkToggleKeepsSelectedDetailInSync() {
        let store = ReducerLessonStore()
        let lesson = SharedLessonDomain.sampleLessons()[0]

        store.send(.selectLesson(lesson.id))
        store.send(.toggleBookmark(lesson.id))

        XCTAssertEqual(store.detailViewState()?.title, lesson.title)
        XCTAssertEqual(store.detailViewState()?.bookmarkButtonTitle, "Remove Bookmark")
    }
}
