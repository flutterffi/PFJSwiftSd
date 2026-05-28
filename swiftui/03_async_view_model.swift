import SwiftUI

@MainActor
final class DashboardViewModel: ObservableObject {
    enum ViewState {
        case idle
        case loading
        case loaded([String])
        case failed(String)
    }

    @Published private(set) var state: ViewState = .idle

    func load() async {
        state = .loading

        do {
            try await Task.sleep(nanoseconds: 250_000_000)
            state = .loaded(["Actors", "NavigationStack", "Observation"])
        } catch {
            state = .failed("Loading interrupted")
        }
    }
}

struct AsyncDashboardView: View {
    @StateObject private var viewModel = DashboardViewModel()

    var body: some View {
        content
            .task {
                if case .idle = viewModel.state {
                    await viewModel.load()
                }
            }
            .padding()
    }

    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .idle, .loading:
            ProgressView("Loading lessons...")
        case let .loaded(lessons):
            List(lessons, id: \.self) { lesson in
                Text(lesson)
            }
        case let .failed(message):
            VStack(spacing: 12) {
                Text(message)
                Button("Retry") {
                    Task {
                        await viewModel.load()
                    }
                }
            }
        }
    }
}

#Preview {
    AsyncDashboardView()
}
