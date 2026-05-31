import XCTest
@testable import MVCApp

final class MVCLessonControllerTests: XCTestCase {
    func testQueryAndBookmarkFlowUpdatesRenderedState() {
        let controller = MVCLessonController()
        var latestState: MVCLessonListViewState?
        controller.onListStateChange = { latestState = $0 }

        controller.viewDidLoad()
        controller.updateQuery("task")

        XCTAssertEqual(latestState?.rows.count, 1)
        let lessonID = controller.visibleLessons[0].id
        controller.toggleBookmark(for: lessonID)

        XCTAssertEqual(controller.detailViewState(for: lessonID)?.bookmarkButtonTitle, "Remove Bookmark")
    }

    func testSelectingLessonRoutesToDetail() {
        let controller = MVCLessonController()
        let lessonID = controller.lessons[0].id

        controller.selectLesson(lessonID)

        XCTAssertEqual(controller.router.selectedLesson?.id, lessonID)
    }
}
