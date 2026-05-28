import Foundation

enum LessonTrack: String, CaseIterable, Codable {
    case foundations
    case language
    case concurrency
    case swiftUI = "swiftui"
    case architecture
}

struct Lesson: Identifiable, Codable, Hashable {
    let id: UUID
    let title: String
    let track: LessonTrack
    let estimatedMinutes: Int
}

struct DashboardState {
    var lessons: [Lesson] = []
    var isLoading = false
    var selectedTrack: LessonTrack?
    var searchQuery = ""
    var bookmarkedLessonIDs: Set<UUID> = []
    var errorMessage: String?

    var visibleLessons: [Lesson] {
        lessons.filter { lesson in
            let matchesTrack = selectedTrack.map { lesson.track == $0 } ?? true
            let normalizedQuery = searchQuery.trimmingCharacters(in: .whitespacesAndNewlines)
            let matchesQuery = normalizedQuery.isEmpty
                || lesson.title.localizedCaseInsensitiveContains(normalizedQuery)
                || lesson.track.rawValue.localizedCaseInsensitiveContains(normalizedQuery)
            return matchesTrack && matchesQuery
        }
    }
}

enum DashboardAction {
    case loadTapped
    case lessonsLoaded([Lesson])
    case failed(String)
    case searchChanged(String)
    case trackChanged(LessonTrack?)
    case bookmarksLoaded(Set<UUID>)
    case bookmarkToggled(UUID)
}

struct DashboardEnvironment {
    var fetchLessons: () async throws -> [Lesson]
    var loadBookmarks: () throws -> Set<UUID>
    var saveBookmarks: (Set<UUID>) throws -> Void
}

struct DashboardStore {
    private(set) var state: DashboardState
    let environment: DashboardEnvironment

    init(
        state: DashboardState = DashboardState(),
        environment: DashboardEnvironment
    ) {
        self.state = state
        self.environment = environment
    }

    mutating func send(_ action: DashboardAction) async {
        switch action {
        case .loadTapped:
            state.isLoading = true
            state.errorMessage = nil

            do {
                let lessons = try await environment.fetchLessons()
                let bookmarks = try environment.loadBookmarks()
                await send(.lessonsLoaded(lessons))
                await send(.bookmarksLoaded(bookmarks))
            } catch {
                await send(.failed("Unable to load dashboard data"))
            }

        case let .lessonsLoaded(lessons):
            state.isLoading = false
            state.lessons = lessons

        case let .failed(message):
            state.isLoading = false
            state.errorMessage = message

        case let .searchChanged(query):
            state.searchQuery = query

        case let .trackChanged(track):
            state.selectedTrack = track

        case let .bookmarksLoaded(bookmarks):
            state.bookmarkedLessonIDs = bookmarks

        case let .bookmarkToggled(id):
            if state.bookmarkedLessonIDs.contains(id) {
                state.bookmarkedLessonIDs.remove(id)
            } else {
                state.bookmarkedLessonIDs.insert(id)
            }

            do {
                try environment.saveBookmarks(state.bookmarkedLessonIDs)
            } catch {
                state.errorMessage = "Unable to save bookmarks"
            }
        }
    }
}

struct BookmarkPersistence {
    let fileURL: URL

    func load() throws -> Set<UUID> {
        guard FileManager.default.fileExists(atPath: fileURL.path) else {
            return []
        }

        let data = try Data(contentsOf: fileURL)
        let values = try JSONDecoder().decode([UUID].self, from: data)
        return Set(values)
    }

    func save(_ bookmarks: Set<UUID>) throws {
        let sorted = bookmarks.map(\.uuidString).sorted().compactMap(UUID.init(uuidString:))
        let data = try JSONEncoder().encode(sorted)
        try data.write(to: fileURL, options: .atomic)
    }
}

func makeSampleLessons() -> [Lesson] {
    [
        Lesson(id: UUID(uuidString: "11111111-1111-1111-1111-111111111111")!, title: "Constants and Variables", track: .foundations, estimatedMinutes: 15),
        Lesson(id: UUID(uuidString: "22222222-2222-2222-2222-222222222222")!, title: "Optionals and Guard", track: .foundations, estimatedMinutes: 20),
        Lesson(id: UUID(uuidString: "33333333-3333-3333-3333-333333333333")!, title: "Value Semantics", track: .language, estimatedMinutes: 25),
        Lesson(id: UUID(uuidString: "44444444-4444-4444-4444-444444444444")!, title: "Task Groups", track: .concurrency, estimatedMinutes: 30),
        Lesson(id: UUID(uuidString: "55555555-5555-5555-5555-555555555555")!, title: "NavigationStack", track: .swiftUI, estimatedMinutes: 35),
        Lesson(id: UUID(uuidString: "66666666-6666-6666-6666-666666666666")!, title: "Feature Store", track: .architecture, estimatedMinutes: 30),
    ]
}

func printDashboard(_ state: DashboardState, title: String) {
    print("\n=== \(title) ===")
    print("Loading:", state.isLoading)
    print("Selected track:", state.selectedTrack?.rawValue ?? "all")
    print("Search query:", state.searchQuery.isEmpty ? "<empty>" : state.searchQuery)
    print("Bookmarks:", state.bookmarkedLessonIDs.count)

    for lesson in state.visibleLessons {
        let bookmarkMark = state.bookmarkedLessonIDs.contains(lesson.id) ? "★" : " "
        print("\(bookmarkMark) \(lesson.title) [\(lesson.track.rawValue)] - \(lesson.estimatedMinutes)m")
    }

    if let errorMessage = state.errorMessage {
        print("Error:", errorMessage)
    }
}

let persistence = BookmarkPersistence(
    fileURL: URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
        .appendingPathComponent("projects/01_study_dashboard_app/bookmarks.json")
)

let environment = DashboardEnvironment(
    fetchLessons: {
        try await Task.sleep(nanoseconds: 150_000_000)
        return makeSampleLessons()
    },
    loadBookmarks: {
        try persistence.load()
    },
    saveBookmarks: { bookmarks in
        try persistence.save(bookmarks)
    }
)

let semaphore = DispatchSemaphore(value: 0)

Task {
    var store = DashboardStore(environment: environment)

    await store.send(.loadTapped)
    printDashboard(store.state, title: "Initial Load")

    await store.send(.searchChanged("task"))
    printDashboard(store.state, title: "Search: task")

    await store.send(.trackChanged(.swiftUI))
    printDashboard(store.state, title: "Track: swiftui")

    await store.send(.searchChanged(""))
    if let lesson = store.state.lessons.first(where: { $0.track == .swiftUI }) {
        await store.send(.bookmarkToggled(lesson.id))
    }
    printDashboard(store.state, title: "After Bookmark Toggle")

    semaphore.signal()
}

semaphore.wait()
