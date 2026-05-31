import Foundation
#if canImport(ArchitectureSharedDomain)
import ArchitectureSharedDomain
#endif

let viewModel = UIKitLessonViewModel()

viewModel.onStateChange = { state in
    print("[UIKit MVVM] \(state.title)")
    print("[UIKit MVVM] rows: \(state.rows.count)")
    print("[UIKit MVVM] bookmarks: \(state.bookmarkCountText)")
    print("[UIKit MVVM] weekly: \(state.weeklySummaryText)")
}

viewModel.load()
viewModel.updateQuery("task")

if let lesson = SharedLessonDomain.sampleLessons().first(where: { $0.title == "Task Groups" }) {
    viewModel.toggleBookmark(for: lesson.id)
    viewModel.selectLesson(lesson.id)
    if let detail = viewModel.detailViewState() {
        print("[UIKit MVVM] detail: \(detail.title)")
        print("[UIKit MVVM] action: \(detail.bookmarkButtonTitle)")
    }
}
