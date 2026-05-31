import XCTest
@testable import ArchitectureSharedDomain
@testable import MVVMUIKitApp
@testable import MVVMSwiftUIApp

@MainActor
final class UIKitSwiftUIMigrationTests: XCTestCase {
    func testQueryFilteringMatchesBetweenUIKitAndSwiftUIMVVM() {
        let uiKitViewModel = UIKitLessonViewModel()
        var latestUIKitState: UIKitLessonListViewState?
        uiKitViewModel.onStateChange = { latestUIKitState = $0 }

        let swiftUIViewModel = MVVMLessonListViewModel()

        uiKitViewModel.load()
        uiKitViewModel.updateQuery("task")
        swiftUIViewModel.filter.query = "task"

        XCTAssertEqual(
            latestUIKitState?.rows.map(\.title),
            swiftUIViewModel.visibleLessons.map(\.title)
        )
    }

    func testBookmarksOnlyFilteringMatchesBetweenUIKitAndSwiftUIMVVM() {
        let uiKitViewModel = UIKitLessonViewModel()
        var latestUIKitState: UIKitLessonListViewState?
        uiKitViewModel.onStateChange = { latestUIKitState = $0 }

        let swiftUIViewModel = MVVMLessonListViewModel()

        uiKitViewModel.load()
        uiKitViewModel.updateBookmarksOnly(true)
        swiftUIViewModel.filter.bookmarksOnly = true

        XCTAssertEqual(
            latestUIKitState?.rows.map(\.title),
            swiftUIViewModel.visibleLessons.map(\.title)
        )
    }

    func testBookmarkToggleProducesMatchingDetailIntent() {
        let lesson = SharedLessonDomain.sampleLessons()[0]
        let uiKitViewModel = UIKitLessonViewModel()
        let swiftUIViewModel = MVVMLessonListViewModel()

        uiKitViewModel.selectLesson(lesson.id)
        uiKitViewModel.toggleBookmark(for: lesson.id)

        swiftUIViewModel.showDetail(for: lesson)
        swiftUIViewModel.toggleBookmark(for: lesson.id)

        guard case let .detail(updatedLesson)? = swiftUIViewModel.path.first else {
            return XCTFail("Expected SwiftUI MVVM to keep an updated detail route.")
        }

        XCTAssertEqual(uiKitViewModel.detailViewState()?.title, updatedLesson.title)
        XCTAssertEqual(uiKitViewModel.detailViewState()?.bookmarkButtonTitle, "Remove Bookmark")
        XCTAssertTrue(updatedLesson.isBookmarked)
    }
}
