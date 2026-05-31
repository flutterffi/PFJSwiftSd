import Foundation
#if canImport(ArchitectureSharedDomain)
import ArchitectureSharedDomain
#endif

final class DemoMVPLessonView: MVPLessonView {
    func renderList(_ model: MVPLessonListViewModel) {
        print("[MVP] \(model.title)")
        print("[MVP] rows: \(model.rows.count)")
        print("[MVP] bookmarks: \(model.bookmarkCountText)")
        print("[MVP] weekly: \(model.weeklySummaryText)")
    }
}

final class DemoMVPLessonRouter: MVPLessonRouting {
    func routeToDetail(for lesson: ArchitectureLesson) {
        print("[MVP] routed detail: \(lesson.title)")
    }
}

let view = DemoMVPLessonView()
let router = DemoMVPLessonRouter()
let presenter = MVPLessonPresenter(view: view, router: router)

presenter.viewDidLoad()
presenter.updateQuery("task")

if let lesson = MVPLessonInteractor().filteredLessons(using: ArchitectureLessonFilter(query: "task")).first {
    presenter.toggleBookmark(for: lesson.id)
    presenter.selectLesson(lesson.id)
    if let detail = presenter.detailViewModel(for: lesson.id) {
        print("[MVP] detail: \(detail.title)")
        print("[MVP] action: \(detail.bookmarkButtonTitle)")
    }
}
