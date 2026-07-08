import Foundation
#if canImport(ArchitectureSharedDomain)
import ArchitectureSharedDomain
#endif

let store = ReducerLessonStore()

store.onListStateChange = { state in
    print("[Reducer] \(state.screenTitle)")
    print("[Reducer] rows: \(state.rows.count)")
    print("[Reducer] bookmarks: \(state.bookmarkCountText)")
    print("[Reducer] weekly: \(state.weeklySummaryText)")
}

store.send(.viewDidLoad)
store.send(.updateQuery("task"))

if let lesson = store.state.visibleLessons.first {
    store.send(.toggleBookmark(lesson.id))
    store.send(.selectLesson(lesson.id))
    if let detail = store.detailViewState() {
        print("[Reducer] detail: \(detail.title)")
        print("[Reducer] action: \(detail.bookmarkButtonTitle)")
    }
}
