import SwiftUI
#if canImport(ArchitectureSharedDomain)
import ArchitectureSharedDomain
#endif

struct MVVMWeeklyReviewView: View {
    let summary: WeeklyReviewSummary

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Weekly Review")
                .font(.largeTitle.bold())

            Text("A compact MVVM-owned summary that can be presented as a sheet without pushing the navigation stack.")
                .foregroundStyle(.secondary)

            HStack(spacing: 16) {
                statCard(title: "Completed", value: "\(summary.completedLessons)")
                statCard(title: "Bookmarked", value: "\(summary.bookmarkedLessons)")
                statCard(title: "Minutes", value: "\(summary.totalMinutes)")
            }

            VStack(alignment: .leading, spacing: 10) {
                Text("Review Prompts")
                    .font(.title3.bold())
                Text("1. Which lessons should become bookmarks for next week?")
                Text("2. Which filters belong in the view model versus the view?")
                Text("3. Should this summary remain derived state or become persisted state?")
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

struct MVVMWeeklyReviewView_Previews: PreviewProvider {
    static var previews: some View {
        MVVMWeeklyReviewView(
            summary: WeeklyReviewSummary(
                completedLessons: 4,
                bookmarkedLessons: 2,
                totalMinutes: 105
            )
        )
    }
}
