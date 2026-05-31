import Foundation
#if canImport(ArchitectureSharedDomain)
import ArchitectureSharedDomain
#endif

enum MVVMRoute: Hashable {
    case bookmarks
    case detail(ArchitectureLesson)
}

enum MVVMSheetRoute: String, Identifiable {
    case weeklyReview

    var id: String { rawValue }
}
