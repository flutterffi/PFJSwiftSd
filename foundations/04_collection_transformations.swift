import Foundation

struct StudyRecord {
    let topic: String
    let minutes: Int
    let completed: Bool
}

let records = [
    StudyRecord(topic: "Swift Basics", minutes: 20, completed: true),
    StudyRecord(topic: "Optionals", minutes: 15, completed: true),
    StudyRecord(topic: "SwiftUI Navigation", minutes: 40, completed: false),
    StudyRecord(topic: "Concurrency", minutes: 30, completed: true),
]

let completedTopics = records
    .filter(\.completed)
    .map(\.topic)

let totalMinutes = records
    .map(\.minutes)
    .reduce(0, +)

print("=== Collection Transformations ===")
print("Completed topics:", completedTopics)
print("Total minutes:", totalMinutes)

print("\nPractice Prompt: group records into short, medium, and long study sessions.")
