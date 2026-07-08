import XCTest
@testable import ArchitectureSharedDomain
@testable import MVVMSwiftUIApp
@testable import ObservationMVVMApp

@MainActor
final class MVVMObservationComparisonTests: XCTestCase {
    func testQueryFilteringMatchesBetweenClassicMVVMAndObservation() {
        let mvvmViewModel = MVVMLessonListViewModel()
        let observationModel = ObservationLessonModel()

        mvvmViewModel.filter.query = "task"
        observationModel.filter.query = "task"

        XCTAssertEqual(
            mvvmViewModel.visibleLessons.map(\.title),
            observationModel.visibleLessons.map(\.title)
        )
    }

    func testBookmarksOnlyFilteringMatchesBetweenClassicMVVMAndObservation() {
        let mvvmViewModel = MVVMLessonListViewModel()
        let observationModel = ObservationLessonModel()

        mvvmViewModel.filter.bookmarksOnly = true
        observationModel.filter.bookmarksOnly = true

        XCTAssertEqual(
            mvvmViewModel.visibleLessons.map(\.title),
            observationModel.visibleLessons.map(\.title)
        )
    }

    func testBookmarkToggleKeepsDetailRouteInSyncAcrossBothImplementations() {
        let lesson = SharedLessonDomain.sampleLessons()[0]
        let mvvmViewModel = MVVMLessonListViewModel()
        let observationModel = ObservationLessonModel()

        mvvmViewModel.showDetail(for: lesson)
        observationModel.showDetail(for: lesson)

        mvvmViewModel.toggleBookmark(for: lesson.id)
        observationModel.toggleBookmark(for: lesson.id)

        guard case let .detail(mvvmLesson)? = mvvmViewModel.path.first else {
            return XCTFail("Expected classic MVVM detail route to stay active.")
        }

        guard case let .detail(observationLesson)? = observationModel.path.first else {
            return XCTFail("Expected Observation detail route to stay active.")
        }

        XCTAssertEqual(mvvmLesson.isBookmarked, observationLesson.isBookmarked)
        XCTAssertEqual(mvvmLesson.title, observationLesson.title)
    }

    func testBookmarksRouteMatchesBetweenClassicMVVMAndObservation() {
        let mvvmViewModel = MVVMLessonListViewModel()
        let observationModel = ObservationLessonModel()

        mvvmViewModel.showBookmarks()
        observationModel.showBookmarks()

        XCTAssertEqual(mvvmViewModel.path, [.bookmarks])
        XCTAssertEqual(observationModel.path, [.bookmarks])
    }

    func testWeeklyReviewIntentMatchesBetweenClassicMVVMAndObservation() {
        let mvvmViewModel = MVVMLessonListViewModel()
        let observationModel = ObservationLessonModel()

        mvvmViewModel.showWeeklyReview()
        observationModel.showWeeklyReview()

        XCTAssertEqual(mvvmViewModel.activeSheet, .weeklyReview)
        XCTAssertEqual(observationModel.activeSheet, .weeklyReview)
    }

    func testLoadFailureMessageMatchesBetweenClassicMVVMAndObservation() {
        let mvvmViewModel = MVVMLessonListViewModel(service: FailingMVVMLessonComparisonService())
        let observationModel = ObservationLessonModel(service: FailingObservationComparisonService())

        XCTAssertEqual(mvvmViewModel.errorMessage, "Unable to load saved bookmarks.")
        XCTAssertEqual(observationModel.errorMessage, "Unable to load saved bookmarks.")
    }

    func testSaveFailureMessageMatchesBetweenClassicMVVMAndObservation() {
        let lesson = SharedLessonDomain.sampleLessons()[0]
        let mvvmViewModel = MVVMLessonListViewModel(service: FailingMVVMLessonComparisonService())
        let observationModel = ObservationLessonModel(service: FailingObservationComparisonService())

        mvvmViewModel.dismissError()
        observationModel.dismissError()

        mvvmViewModel.toggleBookmark(for: lesson.id)
        observationModel.toggleBookmark(for: lesson.id)

        XCTAssertEqual(mvvmViewModel.errorMessage, "Unable to save bookmarks.")
        XCTAssertEqual(observationModel.errorMessage, "Unable to save bookmarks.")
    }

    func testPersistedBookmarkLoadMatchesBetweenClassicMVVMAndObservation() throws {
        let tempDirectory = FileManager.default.temporaryDirectory
            .appendingPathComponent("pfjswiftsd-mvvm-observation-comparison", isDirectory: true)
        try? FileManager.default.removeItem(at: tempDirectory)
        try FileManager.default.createDirectory(at: tempDirectory, withIntermediateDirectories: true)
        defer {
            try? FileManager.default.removeItem(at: tempDirectory)
        }

        let fileURL = tempDirectory.appendingPathComponent("bookmarks.json")
        let targetID = SharedLessonDomain.sampleLessons()[0].id

        let mvvmPersistence = MVVMBookmarkPersistence(fileURL: fileURL)
        try mvvmPersistence.save([targetID])

        let mvvmViewModel = MVVMLessonListViewModel(
            service: PersistedMVVMLessonService(persistence: mvvmPersistence)
        )
        let observationModel = ObservationLessonModel(
            service: PersistedObservationLessonService(
                persistence: ObservationBookmarkPersistence(fileURL: fileURL)
            )
        )

        XCTAssertEqual(
            mvvmViewModel.bookmarkedLessons.map(\.id).sorted(by: { $0.uuidString < $1.uuidString }),
            observationModel.bookmarkedLessons.map(\.id).sorted(by: { $0.uuidString < $1.uuidString })
        )
    }
}

private struct FailingMVVMLessonComparisonService: MVVMLessonService {
    func loadLessons() throws -> [ArchitectureLesson] {
        throw MVVMObservationComparisonError.loadFailed
    }

    func toggleBookmark(in lessons: [ArchitectureLesson], lessonID: UUID) throws -> [ArchitectureLesson] {
        throw MVVMObservationComparisonError.saveFailed
    }
}

private struct FailingObservationComparisonService: ObservationLessonService {
    func loadLessons() throws -> [ArchitectureLesson] {
        throw MVVMObservationComparisonError.loadFailed
    }

    func toggleBookmark(in lessons: [ArchitectureLesson], lessonID: UUID) throws -> [ArchitectureLesson] {
        throw MVVMObservationComparisonError.saveFailed
    }
}

private enum MVVMObservationComparisonError: Error {
    case loadFailed
    case saveFailed
}
