import SwiftUI
#if canImport(ArchitectureSharedDomain)
import ArchitectureSharedDomain
#endif

@main
struct MVVMSwiftUIApp: App {
    @StateObject private var viewModel = MVVMLessonListViewModel()

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                MVVMLessonListView(viewModel: viewModel)
            }
            .frame(minWidth: 760, minHeight: 540)
        }
    }
}
