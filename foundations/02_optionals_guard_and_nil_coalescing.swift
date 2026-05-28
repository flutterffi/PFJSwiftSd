import Foundation

func buildLessonSummary(topic: String?, duration: Int?) -> String {
    guard let topic, !topic.isEmpty else {
        return "Missing topic"
    }

    let safeDuration = duration ?? 0
    return "\(topic) planned for \(safeDuration) minutes"
}

let summaries = [
    buildLessonSummary(topic: "Protocols", duration: 35),
    buildLessonSummary(topic: nil, duration: 20),
    buildLessonSummary(topic: "Observation", duration: nil),
]

print("=== Optionals and Guard ===")
summaries.forEach { print($0) }

print("\nPractice Prompt: return a Result<String, LessonError> instead of plain text.")
