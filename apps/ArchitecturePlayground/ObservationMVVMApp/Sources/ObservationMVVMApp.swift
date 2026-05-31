import SwiftUI
#if canImport(ArchitectureSharedDomain)
import ArchitectureSharedDomain
#endif

@main
struct ObservationMVVMApp: App {
    @State private var model = ObservationLessonModel()

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ObservationLessonListView(model: model)
            }
            .frame(minWidth: 760, minHeight: 540)
        }
    }
}
