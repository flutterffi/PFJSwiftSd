import Foundation

struct StudySession {
    var topic: String
    var minutes: Int
    var tags: [String]

    mutating func addTag(_ tag: String) {
        if !tags.contains(tag) {
            tags.append(tag)
        }
    }
}

func printSection(_ title: String) {
    print("\n=== \(title) ===")
}

var original = StudySession(topic: "SwiftUI", minutes: 40, tags: ["ui", "state"])
var copied = original

copied.minutes = 55
copied.addTag("navigation")

printSection("Value Semantics")
print("original:", original)
print("copied:", copied)

printSection("Array Copy-On-Write Intuition")
var backlogA = ["Protocols", "Actors", "NavigationStack"]
var backlogB = backlogA
backlogB.append("TaskGroup")

print("backlogA:", backlogA)
print("backlogB:", backlogB)

printSection("Practice Prompt")
print("Turn StudySession into an immutable design with helper methods that return a new value.")
