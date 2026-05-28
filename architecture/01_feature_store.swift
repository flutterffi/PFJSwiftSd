import Foundation

struct DashboardState {
    var lessons: [String] = []
    var isLoading = false
    var selectedFilter: Filter = .all
    var errorMessage: String?

    enum Filter: String, CaseIterable {
        case all
        case language
        case swiftUI = "swiftui"
    }
}

enum DashboardAction {
    case loadTapped
    case lessonsLoaded([String])
    case failed(String)
    case filterChanged(DashboardState.Filter)
}

struct DashboardEnvironment {
    var fetchLessons: () async throws -> [String]
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
                await send(.lessonsLoaded(lessons))
            } catch {
                await send(.failed("Unable to load lessons"))
            }

        case let .lessonsLoaded(lessons):
            state.isLoading = false
            state.lessons = lessons

        case let .failed(message):
            state.isLoading = false
            state.errorMessage = message

        case let .filterChanged(filter):
            state.selectedFilter = filter
        }
    }
}

let semaphore = DispatchSemaphore(value: 0)

Task {
    var store = DashboardStore(
        environment: DashboardEnvironment(
            fetchLessons: {
                try await Task.sleep(nanoseconds: 120_000_000)
                return ["Value Semantics", "Task Groups", "NavigationStack"]
            }
        )
    )

    print("Before load:", store.state)
    await store.send(.loadTapped)
    print("After load:", store.state)

    await store.send(.filterChanged(.swiftUI))
    print("After filter:", store.state)
    semaphore.signal()
}

semaphore.wait()
