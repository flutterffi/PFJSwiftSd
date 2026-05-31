import SwiftUI
#if canImport(ArchitectureSharedDomain)
import ArchitectureSharedDomain
#endif

struct ObservationBookmarksView: View {
    @Bindable var model: ObservationLessonModel

    var body: some View {
        Group {
            if model.bookmarkedLessons.isEmpty {
                ContentUnavailableView(
                    "No Bookmarks Yet",
                    systemImage: "star",
                    description: Text("Save a few lessons from the main list, then review them here.")
                )
            } else {
                List(model.bookmarkedLessons) { lesson in
                    Button {
                        model.showDetail(for: lesson)
                    } label: {
                        HStack(spacing: 12) {
                            VStack(alignment: .leading, spacing: 6) {
                                Text(lesson.title)
                                    .font(.headline)
                                Text(lesson.track.rawValue.uppercased())
                                    .font(.caption.weight(.semibold))
                                    .foregroundStyle(.green)
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
                Text("\(model.bookmarkedLessons.count) saved")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.secondary)
            }
        }
    }
}

struct ObservationBookmarksView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ObservationBookmarksView(model: ObservationLessonModel())
        }
    }
}
