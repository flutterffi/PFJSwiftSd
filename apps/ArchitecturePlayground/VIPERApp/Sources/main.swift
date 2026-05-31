import Foundation
#if canImport(ArchitectureSharedDomain)
import ArchitectureSharedDomain
#endif

final class DemoVIPERLessonView: VIPERLessonView {
    func render(_ model: VIPERLessonListViewModel) {
        print("[VIPER] \(model.title)")
        print("[VIPER] rows: \(model.rows.count)")
        print("[VIPER] bookmarks: \(model.bookmarkCountText)")
        print("[VIPER] weekly: \(model.weeklySummaryText)")
    }
}

final class DemoVIPERLessonRouter: VIPERLessonRouting {
    func routeToDetail(for lesson: ArchitectureLesson) {
        print("[VIPER] routed detail: \(lesson.title)")
    }
}

let presenter = VIPERLessonModuleBuilder.build()
let view = DemoVIPERLessonView()
let router = DemoVIPERLessonRouter()

presenter.view = view
presenter.router = router
presenter.load()
presenter.updateQuery("task")

if let lesson = presenter.interactor.lessons.first(where: { $0.title == "Task Groups" }) {
    presenter.toggleBookmark(for: lesson.id)
    presenter.selectLesson(lesson)
    if let detail = presenter.detailViewModel(for: lesson.id) {
        print("[VIPER] detail: \(detail.title)")
        print("[VIPER] action: \(detail.bookmarkButtonTitle)")
    }
}
