import Foundation
import Observation
#if canImport(ArchitectureSharedDomain)
import ArchitectureSharedDomain
#endif

@Observable
final class ObservationLessonModel {
    var lessons: [ArchitectureLesson] = SharedLessonDomain.sampleLessons()
    var filter = ArchitectureLessonFilter()

    var visibleLessons: [ArchitectureLesson] {
        SharedLessonDomain.filteredLessons(from: lessons, filter: filter)
    }

    var weeklySummary: WeeklyReviewSummary {
        SharedLessonDomain.weeklyReviewSummary(from: lessons)
    }

    func toggleBookmark(for lessonID: UUID) {
        lessons = lessons.map { lesson in
            guard lesson.id == lessonID else { return lesson }
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
