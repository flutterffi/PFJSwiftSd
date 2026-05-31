import Foundation
#if canImport(ArchitectureSharedDomain)
import ArchitectureSharedDomain
#endif

@MainActor
final class MVVMLessonListViewModel: ObservableObject {
    @Published private(set) var lessons: [ArchitectureLesson]
    @Published var filter = ArchitectureLessonFilter()

    init(lessons: [ArchitectureLesson] = SharedLessonDomain.sampleLessons()) {
        self.lessons = lessons
    }

    var visibleLessons: [ArchitectureLesson] {
        SharedLessonDomain.filteredLessons(from: lessons, filter: filter)
    }

    var weeklySummary: WeeklyReviewSummary {
        SharedLessonDomain.weeklyReviewSummary(from: lessons)
    }

    func toggleBookmark(for lessonID: UUID) {
        lessons = lessons.map { lesson in
            guard lesson.id == lessonID else {
                return lesson
            }

            return ArchitectureLesson(
                id: lesson.id,
                title: lesson.title,
                track: lesson.track,
                estimatedMinutes: lesson.estimatedMinutes,
                isBookmarked: !lesson.isBookmarked
            )
        }
    }
}
