import XCTest
@testable import VIPERApp
@testable import ArchitectureSharedDomain

final class VIPERLessonPresenterTests: XCTestCase {
    func testPresenterRendersFilteredRows() {
        let presenter = VIPERLessonPresenter()
        let view = VIPERTestView()
        presenter.view = view

        presenter.load()
        presenter.updateQuery("task")

        XCTAssertEqual(view.latestModel?.rows.count, 1)
        XCTAssertEqual(view.latestModel?.rows.first?.title, "Task Groups")
    }

    func testPresenterRoutesSelectedLesson() {
        let presenter = VIPERLessonPresenter()
        let router = VIPERTestRouter()
        presenter.router = router
        let lesson = SharedLessonDomain.sampleLessons()[0]

        presenter.selectLesson(lesson)

        XCTAssertEqual(router.selectedLesson?.id, lesson.id)
    }
}

private final class VIPERTestView: VIPERLessonView {
    var latestModel: VIPERLessonListViewModel?

    func render(_ model: VIPERLessonListViewModel) {
        latestModel = model
    }
}

private final class VIPERTestRouter: VIPERLessonRouting {
    var selectedLesson: ArchitectureLesson?

    func routeToDetail(for lesson: ArchitectureLesson) {
        selectedLesson = lesson
    }
}
