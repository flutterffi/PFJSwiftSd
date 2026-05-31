import Foundation
#if canImport(ArchitectureSharedDomain)
import ArchitectureSharedDomain
#endif

enum ObservationRoute: Hashable {
    case bookmarks
    case detail(ArchitectureLesson)
}

enum ObservationSheetRoute: String, Identifiable {
    case weeklyReview

    var id: String { rawValue }
}
