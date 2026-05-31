import XCTest
@testable import MVVMUIKitApp
@testable import ArchitectureSharedDomain

final class UIKitLessonViewModelTests: XCTestCase {
    func testLoadAndFilterPublishesRows() {
        let viewModel = UIKitLessonViewModel()
        var latestState: UIKitLessonListViewState?
        viewModel.onStateChange = { latestState = $0 }

        viewModel.load()
        viewModel.updateQuery("task")

        XCTAssertEqual(latestState?.rows.count, 1)
        XCTAssertEqual(latestState?.rows.first?.title, "Task Groups")
    }

    func testSelectionAndDetailProjectionStayInSync() {
        let viewModel = UIKitLessonViewModel()
        let lesson = SharedLessonDomain.sampleLessons()[0]

        viewModel.selectLesson(lesson.id)
        viewModel.toggleBookmark(for: lesson.id)

        XCTAssertEqual(viewModel.detailViewState()?.title, lesson.title)
        XCTAssertEqual(viewModel.detailViewState()?.bookmarkButtonTitle, "Remove Bookmark")
    }
}
