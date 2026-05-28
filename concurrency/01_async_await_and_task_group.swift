import Foundation

struct LessonMetric: Sendable {
    let topic: String
    let retentionScore: Int
}

func fetchMetric(for topic: String) async throws -> LessonMetric {
    try await Task.sleep(nanoseconds: 150_000_000)

    if Task.isCancelled {
        throw CancellationError()
    }

    return LessonMetric(topic: topic, retentionScore: Int.random(in: 70...98))
}

func loadMetrics(for topics: [String]) async throws -> [LessonMetric] {
    try await withThrowingTaskGroup(of: LessonMetric.self) { group in
        for topic in topics {
            group.addTask {
                try await fetchMetric(for: topic)
            }
        }

        var results: [LessonMetric] = []
        for try await metric in group {
            results.append(metric)
        }
        return results.sorted { $0.topic < $1.topic }
    }
}

let topics = ["Actors", "SwiftUI", "Generics", "NavigationStack"]
let semaphore = DispatchSemaphore(value: 0)

Task {
    do {
        let metrics = try await loadMetrics(for: topics)
        print("=== Loaded Metrics ===")
        metrics.forEach { print("\($0.topic): \($0.retentionScore)") }
    } catch is CancellationError {
        print("The metrics task was cancelled.")
    } catch {
        print("Unexpected error:", error)
    }

    print("\nPractice Prompt: return partial successes instead of failing the whole group.")
    semaphore.signal()
}

semaphore.wait()
