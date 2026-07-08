import XCTest
@testable import ArchitectureSharedDomain
@testable import MVVMSwiftUIApp
@testable import ReducerStyleApp

@MainActor
final class MVVMReducerComparisonTests: XCTestCase {
    func testQueryFilteringMatchesBetweenMVVMAndReducer() {
        let mvvmViewModel = MVVMLessonListViewModel()
        let reducerStore = ReducerLessonStore()

        mvvmViewModel.filter.query = "task"
        reducerStore.send(.updateQuery("task"))

        XCTAssertEqual(
            mvvmViewModel.visibleLessons.map(\.title),
            reducerStore.state.visibleLessons.map(\.title)
        )
    }

    func testBookmarksOnlyFilteringMatchesBetweenMVVMAndReducer() {
        let mvvmViewModel = MVVMLessonListViewModel()
        let reducerStore = ReducerLessonStore()

        mvvmViewModel.filter.bookmarksOnly = true
        reducerStore.send(.updateBookmarksOnly(true))

        XCTAssertEqual(
            mvvmViewModel.visibleLessons.map(\.title),
            reducerStore.state.visibleLessons.map(\.title)
        )
    }

    func testBookmarkToggleProducesMatchingDetailIntent() {
        let lesson = SharedLessonDomain.sampleLessons()[0]
        let mvvmViewModel = MVVMLessonListViewModel()
        let reducerStore = ReducerLessonStore()

        mvvmViewModel.showDetail(for: lesson)
        mvvmViewModel.toggleBookmark(for: lesson.id)

        reducerStore.send(.selectLesson(lesson.id))
        reducerStore.send(.toggleBookmark(lesson.id))

        guard case let .detail(updatedLesson)? = mvvmViewModel.path.first else {
            return XCTFail("Expected MVVM detail route to stay active.")
        }

        XCTAssertEqual(updatedLesson.title, reducerStore.detailViewState()?.title)
        XCTAssertEqual(updatedLesson.isBookmarked, true)
        XCTAssertEqual(reducerStore.detailViewState()?.bookmarkButtonTitle, "Remove Bookmark")
    }
}
