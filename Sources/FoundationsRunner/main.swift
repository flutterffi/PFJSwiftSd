import Foundation

struct FoundationsLesson {
    let id: String
    let title: String
    let relativePath: String
}

let lessons: [FoundationsLesson] = [
    FoundationsLesson(
        id: "01",
        title: "Constants, Variables, and Interpolation",
        relativePath: "foundations/01_constants_variables_and_interpolation.swift"
    ),
    FoundationsLesson(
        id: "02",
        title: "Optionals, Guard, and Nil Coalescing",
        relativePath: "foundations/02_optionals_guard_and_nil_coalescing.swift"
    ),
    FoundationsLesson(
        id: "03",
        title: "Enums, Structs, and Methods",
        relativePath: "foundations/03_enums_structs_and_methods.swift"
    ),
    FoundationsLesson(
        id: "04",
        title: "Collection Transformations",
        relativePath: "foundations/04_collection_transformations.swift"
    ),
]

let arguments = Array(CommandLine.arguments.dropFirst())

guard let rootDirectory = findRepositoryRoot(startingAt: URL(fileURLWithPath: FileManager.default.currentDirectoryPath)) else {
    fputs("Unable to locate the PFJSwiftSd repository root.\n", stderr)
    Foundation.exit(1)
}

if arguments.isEmpty || arguments.first == "help" || arguments.first == "--help" {
    printUsage()
    Foundation.exit(0)
}

if arguments.first == "list" {
    printLessonList()
    Foundation.exit(0)
}

let lessonID = arguments[0]
guard let lesson = lessons.first(where: { $0.id == lessonID }) else {
    fputs("Unknown foundations lesson: \(lessonID)\n", stderr)
    printLessonList()
    Foundation.exit(1)
}

let lessonURL = rootDirectory.appendingPathComponent(lesson.relativePath)
let moduleCacheURL = rootDirectory.appendingPathComponent(".build/ModuleCache", isDirectory: true)
try? FileManager.default.createDirectory(at: moduleCacheURL, withIntermediateDirectories: true)

let process = Process()
process.executableURL = URL(fileURLWithPath: "/usr/bin/swift")
process.arguments = [
    "-module-cache-path",
    moduleCacheURL.path,
    lessonURL.path,
]
process.currentDirectoryURL = rootDirectory
process.standardInput = FileHandle.standardInput
process.standardOutput = FileHandle.standardOutput
process.standardError = FileHandle.standardError

do {
    try process.run()
    process.waitUntilExit()
    Foundation.exit(process.terminationStatus)
} catch {
    fputs("Failed to run lesson \(lesson.id): \(error)\n", stderr)
    Foundation.exit(1)
}

func printUsage() {
    print("PFJSwiftSd FoundationsRunner")
    print("")
    print("Usage:")
    print("  swift run FoundationsRunner list")
    print("  swift run FoundationsRunner 01")
    print("  swift run FoundationsRunner 02")
    print("")
    print("Commands:")
    print("  list     Show all available foundations lessons")
    print("  01-04    Run a foundations lesson by number")
}

func printLessonList() {
    print("Foundations lessons:")
    for lesson in lessons {
        print("  \(lesson.id)  \(lesson.title)")
    }
}

func findRepositoryRoot(startingAt url: URL) -> URL? {
    var currentURL = url

    while true {
        let packageURL = currentURL.appendingPathComponent("Package.swift")
        if FileManager.default.fileExists(atPath: packageURL.path) {
            return currentURL
        }

        let parentURL = currentURL.deletingLastPathComponent()
        if parentURL.path == currentURL.path {
            return nil
        }
        currentURL = parentURL
    }
}
