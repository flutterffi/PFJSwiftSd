import XCTest
@testable import MVPApp
@testable import ArchitectureSharedDomain

final class MVPLessonPresenterTests: XCTestCase {
    func testPresenterRendersFilteredRows() {
        let view = MVPTestView()
        let presenter = MVPLessonPresenter(view: view)

        presenter.viewDidLoad()
        presenter.updateQuery("task")

        XCTAssertEqual(view.latestModel?.rows.count, 1)
        XCTAssertEqual(view.latestModel?.rows.first?.title, "Task Groups")
    }

    func testPresenterRoutesSelectedLesson() {
        let router = MVPTestRouter()
        let presenter = MVPLessonPresenter(router: router)
        let lessonID = SharedLessonDomain.sampleLessons()[0].id

        presenter.selectLesson(lessonID)

        XCTAssertEqual(router.selectedLesson?.id, lessonID)
    }
}

private final class MVPTestView: MVPLessonView {
    var latestModel: MVPLessonListViewModel?

    func renderList(_ model: MVPLessonListViewModel) {
        latestModel = model
    }
}

private final class MVPTestRouter: MVPLessonRouting {
    var selectedLesson: ArchitectureLesson?

    func routeToDetail(for lesson: ArchitectureLesson) {
        selectedLesson = lesson
    }
}
