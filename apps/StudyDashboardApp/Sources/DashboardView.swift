import SwiftUI
#if canImport(StudyDashboardFeatureCore)
import StudyDashboardFeatureCore
#endif

struct DashboardView: View {
    @ObservedObject var viewModel: DashboardViewModel

    var body: some View {
        VStack(spacing: 0) {
            header
            Divider()
            content
        }
        .navigationTitle("Study Dashboard")
        .searchable(
            text: Binding(
                get: { viewModel.state.searchQuery },
                set: { newValue in
                    Task {
                        await viewModel.searchChanged(newValue)
                    }
                }
            ),
            prompt: "Search lessons or tracks"
        )
        .task {
            await viewModel.loadIfNeeded()
        }
        .alert(
            "Dashboard Notice",
            isPresented: Binding(
                get: { viewModel.state.errorMessage != nil },
                set: { _ in }
            )
        ) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(viewModel.state.errorMessage ?? "")
        }
    }

    private var header: some View {
        HStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 6) {
                Text("Swift + SwiftUI Training")
                    .font(.title2.bold())
                Text("Search, filter, and bookmark lessons using the extracted dashboard core.")
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Picker(
                "Track",
                selection: Binding(
                    get: { viewModel.state.selectedTrack },
                    set: { newValue in
                        Task {
                            await viewModel.trackChanged(newValue)
                        }
                    }
                )
            ) {
                Text("All").tag(LessonTrack?.none)
                ForEach(LessonTrack.allCases, id: \.self) { track in
                    Text(track.rawValue.capitalized).tag(LessonTrack?.some(track))
                }
            }
            .pickerStyle(.segmented)
            .frame(maxWidth: 420)
        }
        .padding(20)
    }

    @ViewBuilder
    private var content: some View {
        if viewModel.state.isLoading {
            VStack {
                Spacer()
                ProgressView("Loading lessons...")
                Spacer()
            }
        } else if viewModel.state.visibleLessons.isEmpty {
            VStack(spacing: 10) {
                Spacer()
                Text("No lessons found")
                    .font(.headline)
                Text("Try a different search query or track filter.")
                    .foregroundStyle(.secondary)
                Spacer()
            }
        } else {
            List(viewModel.state.visibleLessons) { lesson in
                NavigationLink {
                    LessonDetailView(
                        lesson: lesson,
                        isBookmarked: viewModel.state.bookmarkedLessonIDs.contains(lesson.id),
                        onToggleBookmark: {
                            Task {
                                await viewModel.toggleBookmark(for: lesson.id)
                            }
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

                        Button {
                            Task {
                                await viewModel.toggleBookmark(for: lesson.id)
                            }
                        } label: {
                            Image(systemName: viewModel.state.bookmarkedLessonIDs.contains(lesson.id) ? "star.fill" : "star")
                                .foregroundStyle(.yellow)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.vertical, 6)
            }
            .listStyle(.inset)
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            DashboardView(viewModel: DashboardViewModel())
        }
    }
}
