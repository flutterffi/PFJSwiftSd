import SwiftUI
import Observation
#if canImport(ArchitectureSharedDomain)
import ArchitectureSharedDomain
#endif

struct ObservationLessonListView: View {
    @Bindable var model: ObservationLessonModel

    var body: some View {
        VStack(spacing: 0) {
            header
            Divider()
            summaryStrip
            Divider()
            content
        }
        .navigationTitle("Observation MVVM App")
        .navigationDestination(for: ObservationRoute.self) { route in
            switch route {
            case .bookmarks:
                ObservationBookmarksView(model: model)
            case let .detail(lesson):
                ObservationLessonDetailView(
                    lesson: lesson,
                    onToggleBookmark: {
                        model.toggleBookmark(for: lesson.id)
                    }
                )
            }
        }
        .searchable(
            text: $model.filter.query,
            prompt: "Search lessons or tracks"
        )
        .sheet(item: $model.activeSheet) { sheet in
            switch sheet {
            case .weeklyReview:
                ObservationWeeklyReviewView(summary: model.weeklySummary)
            }
        }
        .alert("Bookmark Error", isPresented: errorBinding) {
            Button("OK", role: .cancel) {
                model.dismissError()
            }
        } message: {
            Text(model.errorMessage ?? "")
        }
    }

    private var header: some View {
        HStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 6) {
                Text("Architecture Comparison")
                    .font(.title2.bold())
                Text("This version uses SwiftUI Observation to reduce the boilerplate around view-model state publishing.")
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Toggle("Bookmarks Only", isOn: $model.filter.bookmarksOnly)
                .toggleStyle(.switch)
                .frame(maxWidth: 180)

            Button("Bookmarks") {
                model.showBookmarks()
            }
            .buttonStyle(.bordered)

            Button("Weekly Review") {
                model.showWeeklyReview()
            }
            .buttonStyle(.bordered)

            Picker("Track", selection: $model.filter.selectedTrack) {
                Text("All").tag(ArchitectureLessonTrack?.none)
                ForEach(ArchitectureLessonTrack.allCases, id: \.self) { track in
                    Text(track.rawValue.capitalized).tag(ArchitectureLessonTrack?.some(track))
                }
            }
            .pickerStyle(.segmented)
            .frame(maxWidth: 420)
        }
        .padding(20)
    }

    private var summaryStrip: some View {
        HStack(spacing: 16) {
            summaryCard(title: "Completed", value: "\(model.weeklySummary.completedLessons)")
            summaryCard(title: "Bookmarked", value: "\(model.weeklySummary.bookmarkedLessons)")
            summaryCard(title: "Minutes", value: "\(model.weeklySummary.totalMinutes)")
        }
        .padding(20)
    }

    @ViewBuilder
    private var content: some View {
        if model.visibleLessons.isEmpty {
            VStack(spacing: 10) {
                Spacer()
                Text("No lessons found")
                    .font(.headline)
                Text("Try another search or filter configuration.")
                    .foregroundStyle(.secondary)
                Spacer()
            }
        } else {
            List(model.visibleLessons) { lesson in
                Button {
                    model.showDetail(for: lesson)
                } label: {
                    HStack(spacing: 12) {
                        VStack(alignment: .leading, spacing: 6) {
                            Text(lesson.title)
                                .font(.headline)
                            HStack(spacing: 8) {
                                Text(lesson.track.rawValue.uppercased())
                                    .font(.caption.weight(.semibold))
                                    .foregroundStyle(.green)
                                Text("\(lesson.estimatedMinutes) min")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                        }

                        Spacer()

                        Image(systemName: lesson.isBookmarked ? "star.fill" : "star")
                            .foregroundStyle(.yellow)
                    }
                    .padding(.vertical, 6)
                }
                .buttonStyle(.plain)
            }
            .listStyle(.inset)
        }
    }

    private func summaryCard(title: String, value: String) -> some View {
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

    private var errorBinding: Binding<Bool> {
        Binding(
            get: { model.errorMessage != nil },
            set: { isPresented in
                if !isPresented {
                    model.dismissError()
                }
            }
        )
    }
}

struct ObservationLessonListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ObservationLessonListView(model: ObservationLessonModel())
        }
    }
}
