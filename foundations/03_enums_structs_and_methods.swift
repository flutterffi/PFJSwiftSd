import Foundation

enum Track: String {
    case language
    case swiftUI = "swiftui"
    case architecture

    var displayName: String {
        switch self {
        case .language:
            return "Swift Language"
        case .swiftUI:
            return "SwiftUI"
        case .architecture:
            return "Architecture"
        }
    }
}

struct Lesson {
    let title: String
    let track: Track
    private(set) var completed = false

    mutating func markCompleted() {
        completed = true
    }
}

var lesson = Lesson(title: "Enums and Structs", track: .language)

print("=== Enums, Structs, and Methods ===")
print("Before:", lesson)
lesson.markCompleted()
print("After:", lesson)
print("Track display:", lesson.track.displayName)

print("\nPractice Prompt: add a progress percentage and a method that clamps it between 0 and 100.")
