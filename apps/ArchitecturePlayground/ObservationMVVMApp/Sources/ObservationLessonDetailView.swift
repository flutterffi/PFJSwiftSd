import SwiftUI
#if canImport(ArchitectureSharedDomain)
import ArchitectureSharedDomain
#endif

struct ObservationLessonDetailView: View {
    let lesson: ArchitectureLesson
    let onToggleBookmark: () -> Void

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text(lesson.track.rawValue.uppercased())
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.green)

                Text(lesson.title)
                    .font(.largeTitle.bold())

                Text(detailSummary)
                    .foregroundStyle(.secondary)

                detailCard(title: "Estimated Time", value: "\(lesson.estimatedMinutes) min")
                detailCard(title: "Architecture Focus", value: "Observation-backed state updates with less publishing boilerplate")

                VStack(alignment: .leading, spacing: 10) {
                    Text("Practice Prompts")
                        .font(.title3.bold())
                    Text("1. Compare this model with the ObservableObject version.")
                    Text("2. Decide which mutations still belong outside the model.")
                    Text("3. Add a new filter and compare the code size to the MVVM variant.")
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
        "This screen exists to compare how Observation-based state simplifies a SwiftUI lesson flow while keeping the same shared domain."
    }
}

struct ObservationLessonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ObservationLessonDetailView(
                lesson: SharedLessonDomain.sampleLessons()[1],
                onToggleBookmark: {}
            )
        }
    }
}
