import Foundation
#if canImport(ArchitectureSharedDomain)
import ArchitectureSharedDomain
#endif

enum MVVMRoute: Hashable {
    case detail(ArchitectureLesson)
}

enum MVVMSheetRoute: String, Identifiable {
    case weeklyReview

    var id: String { rawValue }
}
