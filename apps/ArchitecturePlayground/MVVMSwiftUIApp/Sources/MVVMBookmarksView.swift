import SwiftUI
#if canImport(ArchitectureSharedDomain)
import ArchitectureSharedDomain
#endif

struct MVVMBookmarksView: View {
    @ObservedObject var viewModel: MVVMLessonListViewModel

    var body: some View {
        Group {
            if viewModel.bookmarkedLessons.isEmpty {
                ContentUnavailableView(
                    "No Bookmarks Yet",
                    systemImage: "star",
                    description: Text("Save a few lessons from the main list, then review them here.")
                )
            } else {
                List(viewModel.bookmarkedLessons) { lesson in
                    Button {
                        viewModel.showDetail(for: lesson)
                    } label: {
                        HStack(spacing: 12) {
                            VStack(alignment: .leading, spacing: 6) {
                                Text(lesson.title)
                                    .font(.headline)
                                Text(lesson.track.rawValue.uppercased())
                                    .font(.caption.weight(.semibold))
                                    .foregroundStyle(.blue)
                            }

                            Spacer()

                            Text("\(lesson.estimatedMinutes) min")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        .padding(.vertical, 6)
                    }
                    .buttonStyle(.plain)
                }
                .listStyle(.inset)
            }
        }
        .navigationTitle("Bookmarks")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Text("\(viewModel.bookmarkedLessons.count) saved")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.secondary)
            }
        }
    }
}

struct MVVMBookmarksView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MVVMBookmarksView(viewModel: MVVMLessonListViewModel())
        }
    }
}
