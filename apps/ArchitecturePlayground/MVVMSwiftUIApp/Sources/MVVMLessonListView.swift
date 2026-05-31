import SwiftUI
#if canImport(ArchitectureSharedDomain)
import ArchitectureSharedDomain
#endif

struct MVVMLessonListView: View {
    @ObservedObject var viewModel: MVVMLessonListViewModel

    var body: some View {
        VStack(spacing: 0) {
            header
            Divider()
            summaryStrip
            Divider()
            content
        }
        .navigationTitle("MVVM SwiftUI App")
        .searchable(
            text: $viewModel.filter.query,
            prompt: "Search lessons or tracks"
        )
    }

    private var header: some View {
        HStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 6) {
                Text("Architecture Comparison")
                    .font(.title2.bold())
                Text("This version uses a SwiftUI + MVVM flow over a shared lesson domain.")
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Toggle("Bookmarks Only", isOn: $viewModel.filter.bookmarksOnly)
                .toggleStyle(.switch)
                .frame(maxWidth: 180)

            Picker("Track", selection: $viewModel.filter.selectedTrack) {
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
            summaryCard(title: "Completed", value: "\(viewModel.weeklySummary.completedLessons)")
            summaryCard(title: "Bookmarked", value: "\(viewModel.weeklySummary.bookmarkedLessons)")
            summaryCard(title: "Minutes", value: "\(viewModel.weeklySummary.totalMinutes)")
        }
        .padding(20)
    }

    @ViewBuilder
    private var content: some View {
        if viewModel.visibleLessons.isEmpty {
            VStack(spacing: 10) {
                Spacer()
                Text("No lessons found")
                    .font(.headline)
                Text("Try another search or filter configuration.")
                    .foregroundStyle(.secondary)
                Spacer()
            }
        } else {
            List(viewModel.visibleLessons) { lesson in
                NavigationLink {
                    MVVMLessonDetailView(
                        lesson: lesson,
                        onToggleBookmark: {
                            viewModel.toggleBookmark(for: lesson.id)
                        }
                    )
                } label: {
                    HStack(spacing: 12) {
                        VStack(alignment: .leading, spacing: 6) {
                            Text(lesson.title)
                                .font(.headline)
                            HStack(spacing: 8) {
                                Text(lesson.track.rawValue.uppercased())
                                    .font(.caption.weight(.semibold))
                                    .foregroundStyle(.blue)
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
}

struct MVVMLessonListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MVVMLessonListView(viewModel: MVVMLessonListViewModel())
        }
    }
}
