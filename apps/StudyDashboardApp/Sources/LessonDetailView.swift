import SwiftUI
#if canImport(StudyDashboardFeatureCore)
import StudyDashboardFeatureCore
#endif

struct LessonDetailView: View {
    let lesson: Lesson
    let isBookmarked: Bool
    let onToggleBookmark: () -> Void

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                titleSection
                statsSection
                practiceSection
                bookmarkSection
            }
            .padding(24)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .navigationTitle("Lesson Detail")
    }

    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(lesson.track.rawValue.uppercased())
                .font(.caption.weight(.semibold))
                .foregroundStyle(.blue)

            Text(lesson.title)
                .font(.largeTitle.bold())

            Text(summaryText)
                .foregroundStyle(.secondary)
        }
    }

    private var statsSection: some View {
        HStack(spacing: 16) {
            detailCard(title: "Estimated Time", value: "\(lesson.estimatedMinutes) min")
            detailCard(title: "Track", value: lesson.track.rawValue.capitalized)
            detailCard(title: "Focus", value: focusLabel)
        }
    }

    private var practiceSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Practice Prompts")
                .font(.title3.bold())

            Text("1. Rewrite one part of this lesson in your own style.")
            Text("2. Add one small variation to the original example.")
            Text("3. Explain when this concept appears in a real app.")
        }
    }

    private var bookmarkSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Study Action")
                .font(.title3.bold())

            Button {
                onToggleBookmark()
            } label: {
                Label(
                    isBookmarked ? "Remove Bookmark" : "Save Bookmark",
                    systemImage: isBookmarked ? "star.slash" : "star.fill"
                )
                .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
        }
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
                .fill(Color.blue.opacity(0.08))
        )
    }

    private var summaryText: String {
        switch lesson.track {
        case .foundations:
            return "Strengthen the base syntax and modeling habits that support the rest of the repository."
        case .language:
            return "Go deeper into how Swift models values, abstractions, and reusable generic code."
        case .concurrency:
            return "Practice async flows, structured concurrency, and safer task-based thinking."
        case .swiftUI:
            return "Connect state, rendering, and navigation into real view-level app behavior."
        case .architecture:
            return "Learn how state, actions, and dependencies can stay organized as features grow."
        }
    }

    private var focusLabel: String {
        switch lesson.track {
        case .foundations:
            return "Syntax"
        case .language:
            return "Modeling"
        case .concurrency:
            return "Async"
        case .swiftUI:
            return "UI"
        case .architecture:
            return "State"
        }
    }
}

struct LessonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            LessonDetailView(
                lesson: Lesson(
                    id: UUID(),
                    title: "NavigationStack",
                    track: .swiftUI,
                    estimatedMinutes: 35
                ),
                isBookmarked: true,
                onToggleBookmark: {}
            )
        }
    }
}
