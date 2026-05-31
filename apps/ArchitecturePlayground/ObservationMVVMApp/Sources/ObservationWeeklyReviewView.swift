import SwiftUI
#if canImport(ArchitectureSharedDomain)
import ArchitectureSharedDomain
#endif

struct ObservationWeeklyReviewView: View {
    let summary: WeeklyReviewSummary

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Weekly Review")
                .font(.largeTitle.bold())

            Text("A compact Observation-driven summary that can be presented without adding more publishing boilerplate.")
                .foregroundStyle(.secondary)

            HStack(spacing: 16) {
                statCard(title: "Completed", value: "\(summary.completedLessons)")
                statCard(title: "Bookmarked", value: "\(summary.bookmarkedLessons)")
                statCard(title: "Minutes", value: "\(summary.totalMinutes)")
            }

            VStack(alignment: .leading, spacing: 10) {
                Text("Review Prompts")
                    .font(.title3.bold())
                Text("1. Which state changes feel simpler with Observation?")
                Text("2. Which service boundaries still matter even when publishing boilerplate shrinks?")
                Text("3. Does this summary belong in the model or as a derived view concern?")
            }

            Spacer()
        }
        .padding(24)
        .frame(minWidth: 540, minHeight: 340, alignment: .topLeading)
    }

    private func statCard(title: String, value: String) -> some View {
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
}

struct ObservationWeeklyReviewView_Previews: PreviewProvider {
    static var previews: some View {
        ObservationWeeklyReviewView(
            summary: WeeklyReviewSummary(
                completedLessons: 4,
                bookmarkedLessons: 2,
                totalMinutes: 105
            )
        )
    }
}
