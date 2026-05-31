import SwiftUI
#if canImport(ArchitectureSharedDomain)
import ArchitectureSharedDomain
#endif

struct MVVMLessonDetailView: View {
    let lesson: ArchitectureLesson
    let onToggleBookmark: () -> Void

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text(lesson.track.rawValue.uppercased())
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.blue)

                Text(lesson.title)
                    .font(.largeTitle.bold())

                Text(detailSummary)
                    .foregroundStyle(.secondary)

                detailCard(title: "Estimated Time", value: "\(lesson.estimatedMinutes) min")
                detailCard(title: "Architecture Focus", value: "MVVM state and view-model driven rendering")

                VStack(alignment: .leading, spacing: 10) {
                    Text("Practice Prompts")
                        .font(.title3.bold())
                    Text("1. Move one more formatting rule into the view model.")
                    Text("2. Add one more filter and keep the view passive.")
                    Text("3. Decide which state belongs in the view and which belongs in the view model.")
                }

                Button {
                    onToggleBookmark()
                } label: {
                    Label(
                        lesson.isBookmarked ? "Remove Bookmark" : "Save Bookmark",
                        systemImage: lesson.isBookmarked ? "star.slash" : "star.fill"
                    )
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
            }
            .padding(24)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .navigationTitle("Lesson Detail")
    }

    private func detailCard(title: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)
            Text(value)
                .font(.headline)
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color.green.opacity(0.08))
        )
    }

    private var detailSummary: String {
        "This screen exists to compare how MVVM organizes state, navigation, and bookmark behavior when the domain is shared across architecture variants."
    }
}

struct MVVMLessonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MVVMLessonDetailView(
                lesson: SharedLessonDomain.sampleLessons()[1],
                onToggleBookmark: {}
            )
        }
    }
}
