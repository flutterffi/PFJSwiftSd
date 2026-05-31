import Foundation
#if canImport(ArchitectureSharedDomain)
import ArchitectureSharedDomain
#endif

struct ReducerLessonRowViewState {
    let id: UUID
    let title: String
    let subtitle: String
    let isBookmarked: Bool
}

struct ReducerLessonListViewState {
    let screenTitle: String
    let rows: [ReducerLessonRowViewState]
    let bookmarkCountText: String
    let weeklySummaryText: String
}

struct ReducerLessonDetailViewState {
    let title: String
    let metadata: String
    let detailSummary: String
    let bookmarkButtonTitle: String
}

struct ReducerLessonState {
    var lessons: [ArchitectureLesson] = SharedLessonDomain.sampleLessons()
    var filter = ArchitectureLessonFilter()
    var selectedLesson: ArchitectureLesson?

    var visibleLessons: [ArchitectureLesson] {
        SharedLessonDomain.filteredLessons(from: lessons, filter: filter)
    }

    var weeklySummary: WeeklyReviewSummary {
        SharedLessonDomain.weeklyReviewSummary(from: lessons)
    }
}

enum ReducerLessonAction {
    case viewDidLoad
    case updateQuery(String)
    case updateTrack(ArchitectureLessonTrack?)
    case updateBookmarksOnly(Bool)
    case toggleBookmark(UUID)
    case selectLesson(UUID)
}

enum ReducerLessonLogic {
    static func reduce(state: inout ReducerLessonState, action: ReducerLessonAction) {
        switch action {
        case .viewDidLoad:
            break
        case let .updateQuery(query):
            state.filter.query = query
        case let .updateTrack(track):
            state.filter.selectedTrack = track
        case let .updateBookmarksOnly(enabled):
            state.filter.bookmarksOnly = enabled
        case let .toggleBookmark(lessonID):
            state.lessons = state.lessons.map { lesson in
                guard lesson.id == lessonID else { return lesson }
                return ArchitectureLesson(
                    id: lesson.id,
                    title: lesson.title,
                    track: lesson.track,
                    estimatedMinutes: lesson.estimatedMinutes,
                    isBookmarked: !lesson.isBookmarked
                )
            }
            if let selectedLesson = state.selectedLesson, selectedLesson.id == lessonID {
                state.selectedLesson = state.lessons.first(where: { $0.id == lessonID })
            }
        case let .selectLesson(lessonID):
            state.selectedLesson = state.lessons.first(where: { $0.id == lessonID })
        }
    }
}

final class ReducerLessonStore {
    private(set) var state: ReducerLessonState
    var onListStateChange: ((ReducerLessonListViewState) -> Void)?

    init(state: ReducerLessonState = ReducerLessonState()) {
        self.state = state
    }

    func send(_ action: ReducerLessonAction) {
        ReducerLessonLogic.reduce(state: &state, action: action)
        renderList()
    }

    func detailViewState() -> ReducerLessonDetailViewState? {
        guard let lesson = state.selectedLesson else {
            return nil
        }

        return ReducerLessonDetailViewState(
            title: lesson.title,
            metadata: "\(lesson.track.rawValue.uppercased()) · \(lesson.estimatedMinutes) min",
            detailSummary: "In a reducer-style flow, state, actions, and mutations stay explicit, which improves traceability but adds ceremony.",
            bookmarkButtonTitle: lesson.isBookmarked ? "Remove Bookmark" : "Save Bookmark"
        )
    }

    private func renderList() {
        let rows = state.visibleLessons.map {
            ReducerLessonRowViewState(
                id: $0.id,
                title: $0.title,
                subtitle: "\($0.track.rawValue.uppercased()) · \($0.estimatedMinutes) min",
                isBookmarked: $0.isBookmarked
            )
        }

        let viewState = ReducerLessonListViewState(
            screenTitle: "Reducer Comparison",
            rows: rows,
            bookmarkCountText: "\(state.lessons.filter(\.isBookmarked).count) bookmarked",
            weeklySummaryText: "\(state.weeklySummary.totalMinutes) total minutes this week"
        )

        onListStateChange?(viewState)
    }
}
