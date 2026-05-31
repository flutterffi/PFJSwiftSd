import Foundation

let controller = MVCLessonController()

controller.onListStateChange = { state in
    print("[MVC] \(state.screenTitle)")
    print("[MVC] rows: \(state.rows.count)")
    print("[MVC] bookmarks: \(state.bookmarkCountText)")
    print("[MVC] weekly: \(state.weeklySummaryText)")
}

controller.viewDidLoad()
controller.updateQuery("task")

if let lesson = controller.visibleLessons.first {
    controller.toggleBookmark(for: lesson.id)
    controller.selectLesson(lesson.id)
    if let detail = controller.detailViewState(for: lesson.id) {
        print("[MVC] detail: \(detail.title)")
        print("[MVC] action: \(detail.bookmarkButtonTitle)")
    }
}
