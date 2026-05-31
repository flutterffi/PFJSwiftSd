import Foundation
#if canImport(ArchitectureSharedDomain)
import ArchitectureSharedDomain
#endif

protocol ObservationLessonService {
    func loadLessons() throws -> [ArchitectureLesson]
    func toggleBookmark(in lessons: [ArchitectureLesson], lessonID: UUID) throws -> [ArchitectureLesson]
}

struct InMemoryObservationLessonService: ObservationLessonService {
    func loadLessons() throws -> [ArchitectureLesson] {
        SharedLessonDomain.sampleLessons()
    }

    func toggleBookmark(in lessons: [ArchitectureLesson], lessonID: UUID) throws -> [ArchitectureLesson] {
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

struct PersistedObservationLessonService: ObservationLessonService {
    let baseLessons: [ArchitectureLesson]
    let persistence: ObservationBookmarkPersistence

    init(
        baseLessons: [ArchitectureLesson] = SharedLessonDomain.sampleLessons(),
        persistence: ObservationBookmarkPersistence
    ) {
        self.baseLessons = baseLessons
        self.persistence = persistence
    }

    func loadLessons() throws -> [ArchitectureLesson] {
        let bookmarks = try persistence.load()
        return mergedLessons(from: baseLessons, bookmarks: bookmarks)
    }

    func toggleBookmark(in lessons: [ArchitectureLesson], lessonID: UUID) throws -> [ArchitectureLesson] {
        let updatedLessons = try InMemoryObservationLessonService().toggleBookmark(in: lessons, lessonID: lessonID)
        let bookmarks = Set(updatedLessons.filter(\.isBookmarked).map(\.id))
        try persistence.save(bookmarks)
        return updatedLessons
    }

    private func mergedLessons(
        from lessons: [ArchitectureLesson],
        bookmarks: Set<UUID>
    ) -> [ArchitectureLesson] {
        lessons.map { lesson in
            ArchitectureLesson(
                id: lesson.id,
                title: lesson.title,
                track: lesson.track,
                estimatedMinutes: lesson.estimatedMinutes,
                isBookmarked: bookmarks.contains(lesson.id)
            )
        }
    }
}
