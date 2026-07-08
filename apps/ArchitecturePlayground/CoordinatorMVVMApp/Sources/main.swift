import Foundation
#if canImport(ArchitectureSharedDomain)
import ArchitectureSharedDomain
#endif

let coordinator = LessonCoordinator()

func printListState(_ state: CoordinatorLessonListViewState) {
    print("[Coordinator] \(state.title)")
    print("[Coordinator] rows: \(state.rows.count)")
    print("[Coordinator] bookmarks: \(state.bookmarkCountText)")
    print("[Coordinator] weekly: \(state.weeklySummaryText)")
}

printListState(coordinator.listViewState())
coordinator.updateQuery("task")
printListState(coordinator.listViewState())

if let lesson = coordinator.visibleLessons.first {
    coordinator.toggleBookmark(for: lesson.id)
    printListState(coordinator.listViewState())
    coordinator.showDetail(for: lesson)

    if case let .detail(updatedLesson)? = coordinator.path.last {
        let detail = coordinator.detailViewState(for: updatedLesson)
        print("[Coordinator] detail: \(detail.title)")
        print("[Coordinator] action: \(detail.bookmarkButtonTitle)")
    }

    coordinator.showWeeklyReview()
    let weekly = coordinator.weeklyReviewViewState()
    print("[Coordinator] weekly title: \(weekly.title)")
    print("[Coordinator] weekly summary: \(weekly.summaryText)")
}
