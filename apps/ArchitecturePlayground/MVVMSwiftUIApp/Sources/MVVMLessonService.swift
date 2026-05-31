import Foundation
#if canImport(ArchitectureSharedDomain)
import ArchitectureSharedDomain
#endif

protocol MVVMLessonService {
    func loadLessons() -> [ArchitectureLesson]
    func toggleBookmark(in lessons: [ArchitectureLesson], lessonID: UUID) -> [ArchitectureLesson]
}

struct InMemoryMVVMLessonService: MVVMLessonService {
    func loadLessons() -> [ArchitectureLesson] {
        SharedLessonDomain.sampleLessons()
    }

    func toggleBookmark(in lessons: [ArchitectureLesson], lessonID: UUID) -> [ArchitectureLesson] {
        lessons.map { lesson in
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
