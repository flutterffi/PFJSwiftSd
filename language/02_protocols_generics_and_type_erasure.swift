import Foundation

protocol StudyRenderable {
    var title: String { get }
    func render() -> String
}

struct LessonCard: StudyRenderable {
    let title: String
    let difficulty: Int

    func render() -> String {
        "\(title) [difficulty: \(difficulty)]"
    }
}

struct ProjectCard: StudyRenderable {
    let title: String
    let milestoneCount: Int

    func render() -> String {
        "\(title) [milestones: \(milestoneCount)]"
    }
}

struct AnyStudyRenderable: StudyRenderable {
    private let storedTitle: String
    private let storedRender: () -> String

    init<T: StudyRenderable>(_ base: T) {
        storedTitle = base.title
        storedRender = base.render
    }

    var title: String { storedTitle }

    func render() -> String {
        storedRender()
    }
}

func renderAll<T: StudyRenderable>(_ items: [T]) {
    for item in items {
        print(item.render())
    }
}

let lessons = [
    LessonCard(title: "Value Semantics", difficulty: 2),
    LessonCard(title: "Type Erasure", difficulty: 4),
]

print("=== Generic Rendering ===")
renderAll(lessons)

let mixedCards: [AnyStudyRenderable] = [
    AnyStudyRenderable(LessonCard(title: "Protocols", difficulty: 3)),
    AnyStudyRenderable(ProjectCard(title: "Study Dashboard", milestoneCount: 5)),
]

print("\n=== Type-Erased Rendering ===")
for card in mixedCards {
    print(card.render())
}

print("\nPractice Prompt: add a QuizCard and keep the mixed array working.")
