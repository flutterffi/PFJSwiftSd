import SwiftUI

struct LessonRowModel: Identifiable {
    let id = UUID()
    let title: String
    let track: String
    let completed: Bool
}

struct LessonListView: View {
    let lessons: [LessonRowModel] = [
        LessonRowModel(title: "Optionals", track: "Foundations", completed: true),
        LessonRowModel(title: "Value Semantics", track: "Language", completed: true),
        LessonRowModel(title: "Task Groups", track: "Concurrency", completed: false),
        LessonRowModel(title: "NavigationStack", track: "SwiftUI", completed: false),
    ]

    var body: some View {
        List {
            ForEach(lessons) { lesson in
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(lesson.title)
                            .font(.headline)
                        Text(lesson.track)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }

                    Spacer()

                    Image(systemName: lesson.completed ? "checkmark.circle.fill" : "circle")
                        .foregroundStyle(lesson.completed ? .green : .gray)
                }
                .padding(.vertical, 4)
            }
        }
        .navigationTitle("Lessons")
    }
}

#Preview {
    NavigationStack {
        LessonListView()
    }
}
