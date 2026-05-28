import SwiftUI

@main
struct StudyDashboardApp: App {
    @StateObject private var viewModel = DashboardViewModel()

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                DashboardView(viewModel: viewModel)
            }
            .frame(minWidth: 720, minHeight: 520)
        }
    }
}
