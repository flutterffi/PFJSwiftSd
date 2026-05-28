import SwiftUI

enum StudyRoute: Hashable {
    case lesson(String)
    case milestone(Int)
}

struct StudyRouterView: View {
    @State private var path: [StudyRoute] = []
    @State private var presentedTopic: String?

    let lessons = ["Value Semantics", "Type Erasure", "Task Groups"]

    var body: some View {
        NavigationStack(path: $path) {
            List {
                Section("Push Navigation") {
                    ForEach(lessons, id: \.self) { lesson in
                        Button(lesson) {
                            path.append(.lesson(lesson))
                        }
                    }
                }

                Section("Sheet Navigation") {
                    Button("Show Weekly Review") {
                        presentedTopic = "Weekly Review"
                    }
                }
            }
            .navigationTitle("Study Router")
            .navigationDestination(for: StudyRoute.self) { route in
                switch route {
                case let .lesson(name):
                    Text("Lesson detail: \(name)")
                case let .milestone(id):
                    Text("Milestone: \(id)")
                }
            }
            .sheet(item: $presentedTopic) { topic in
                Text("Sheet topic: \(topic)")
                    .padding()
            }
        }
    }
}

extension String: Identifiable {
    public var id: String { self }
}

#Preview {
    StudyRouterView()
}
