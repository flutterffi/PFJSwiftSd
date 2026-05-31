# PFJSwiftSd

PFJSwiftSd is an English-first Swift and SwiftUI training repository that starts with solid foundations and grows into advanced app design practice.

The goal is simple:

- keep each lesson focused and practical
- move from Swift language fluency into SwiftUI feature design
- practice concurrency, state management, and architecture with small files
- grow toward real app-level thinking instead of isolated syntax drills

## Official References

Use [OFFICIAL_LEARNING_LINKS.md](/Users/platojobs/Desktop/Github/flutterffi/PFJSwiftSd/docs/OFFICIAL_LEARNING_LINKS.md) as the central index for Swift, SwiftUI, and Xcode documentation from Swift.org and Apple Developer.

For curriculum planning and official-gap analysis, also use:

- [OFFICIAL_ALIGNMENT_PLAN.md](/Users/platojobs/Desktop/Github/flutterffi/PFJSwiftSd/docs/OFFICIAL_ALIGNMENT_PLAN.md)
- [STUDY_SYSTEM_ROADMAP.md](/Users/platojobs/Desktop/Github/flutterffi/PFJSwiftSd/docs/STUDY_SYSTEM_ROADMAP.md)
- [V2_ARCHITECTURE_UPGRADE_PLAN.md](/Users/platojobs/Desktop/Github/flutterffi/PFJSwiftSd/docs/V2_ARCHITECTURE_UPGRADE_PLAN.md)
- [V2_IMPLEMENTATION_SEQUENCE.md](/Users/platojobs/Desktop/Github/flutterffi/PFJSwiftSd/docs/V2_IMPLEMENTATION_SEQUENCE.md)

## Learning Path

### 1. Foundations

The `foundations/` folder builds the language habits that make the later advanced sections easier.

Suggested order:

1. `01_constants_variables_and_interpolation.swift`
2. `02_optionals_guard_and_nil_coalescing.swift`
3. `03_enums_structs_and_methods.swift`
4. `04_collection_transformations.swift`

Topics covered:

- `let` and `var`
- string interpolation
- optionals
- `if let` and `guard`
- enums with computed properties
- structs and methods
- `map`, `filter`, and `reduce`

### 2. Swift Language

The `language/` folder sharpens your Swift fundamentals at a more advanced level.

Suggested order:

1. `01_value_semantics_and_copy_on_write.swift`
2. `02_protocols_generics_and_type_erasure.swift`

Topics covered:

- value semantics
- mutating methods
- copy-on-write thinking
- protocol-oriented design
- generics with constraints
- type erasure

### 3. Concurrency

The `concurrency/` folder moves into modern Swift concurrency.

Suggested order:

1. `01_async_await_and_task_group.swift`

Topics covered:

- `async` and `await`
- structured concurrency
- task groups
- cancellation-aware work

### 4. Architecture

The `architecture/` folder practices feature modeling before UI code gets too large.

Suggested order:

1. `01_feature_store.swift`

Topics covered:

- state and action modeling
- reducer-style updates
- dependency injection
- async effect boundaries

### 5. SwiftUI

The `swiftui/` folder focuses on real SwiftUI concerns instead of only view syntax.

Suggested order:

1. `00_view_composition_and_modifiers.swift`
2. `00_lists_and_identifiable.swift`
3. `01_state_lifecycle.swift`
4. `02_navigation_and_routing.swift`
5. `03_async_view_model.swift`

Topics covered:

- layout composition
- reusable view modifiers
- `List` and `ForEach`
- `Identifiable`
- `@State`, `@Binding`, and `@ObservableObject`
- view identity and lifecycle
- stack-based navigation
- sheet routing
- async loading
- main-actor-safe UI updates

### 6. Projects

The `projects/` folder turns the lessons into a bigger feature direction.

Current project:

1. `01_study_dashboard_app`

### 7. Apps

The `apps/` folder turns reusable training logic into a minimal runnable SwiftUI shell.

Current app:

1. `StudyDashboardApp`
2. `ArchitecturePlayground`

This project practices:

- building a learning dashboard
- combining filters, metrics, and async loading
- splitting screen state from reusable domain logic
- search and bookmark workflows
- local persistence for lightweight app state
- standard SwiftPM tests for domain and persistence logic
- simple lesson detail navigation in SwiftUI
- preparing for a multi-screen SwiftUI app
- cross-architecture app comparison planning
- first MVVM SwiftUI comparison scaffold in ArchitecturePlayground
- full architecture comparison matrix scaffold in ArchitecturePlayground
- stronger Observation and reducer comparison tracks in ArchitecturePlayground
- stronger MVVM app flow with service, route, and weekly review patterns
- MVVM-specific tests for service and view-model behavior
- persisted MVVM bookmark flow with a dedicated bookmarks screen

## Repository Layout

```text
PFJSwiftSd/
  foundations/                # Swift basics with app-oriented examples
  language/                   # advanced Swift language drills
  concurrency/                # async/await and structured concurrency
  architecture/               # feature-state and reducer-style practice
  swiftui/                    # SwiftUI lessons from composition to async screens
  projects/                   # larger feature practice
  apps/                       # runnable SwiftUI app shells
  CHANGELOG.md                # short progress log
```

## Commands You Can Use Later

Pure Swift files can be run from Terminal when Swift is installed:

```bash
swift foundations/01_constants_variables_and_interpolation.swift
swift foundations/02_optionals_guard_and_nil_coalescing.swift
swift foundations/03_enums_structs_and_methods.swift
swift foundations/04_collection_transformations.swift
swift run FoundationsRunner list
swift run FoundationsRunner 01
swift language/01_value_semantics_and_copy_on_write.swift
swift language/02_protocols_generics_and_type_erasure.swift
swift concurrency/01_async_await_and_task_group.swift
swift architecture/01_feature_store.swift
swiftc \
  projects/01_study_dashboard_app/domain/LessonModels.swift \
  projects/01_study_dashboard_app/domain/DashboardStore.swift \
  projects/01_study_dashboard_app/persistence/BookmarkPersistence.swift \
  projects/01_study_dashboard_app/support/SampleData.swift \
  projects/01_study_dashboard_app/study_dashboard_feature.swift \
  -o .build/study_dashboard_feature

./.build/study_dashboard_feature

swift test --filter StudyDashboardFeatureCoreTests
swift test --filter MVVMSwiftUIAppTests

swift build --product StudyDashboardApp
swift build --product MVVMSwiftUIApp
```

If SwiftPM is blocked by a restricted sandbox, run `swift test` and `swift build` in a normal local Terminal session.

SwiftUI files are meant to be opened in Xcode and explored inside an Apple platform app target.

## How To Practice

Use the repository in loops:

1. Read one lesson.
2. Predict the output or behavior.
3. Change one rule or state transition.
4. Run or preview it again.
5. Add one variation beside the original code.

Good modifications to try:

- add a new route to the navigation example
- turn one optional flow into a throwing function
- extract repeated styling into a custom modifier
- introduce one more loading state
- replace an if-else branch with enum-driven rendering
- move screen logic from a view into a store
- add cancellation to one async flow
- add one more store test before changing UI behavior

## Study Companion

For concentrated reading sessions, keep these two pages side by side:

- [foundations/README.md](/Users/platojobs/Desktop/Github/flutterffi/PFJSwiftSd/foundations/README.md)
- [docs/OFFICIAL_LEARNING_LINKS.md](/Users/platojobs/Desktop/Github/flutterffi/PFJSwiftSd/docs/OFFICIAL_LEARNING_LINKS.md)

For repository expansion and long-term study planning, use:

- [docs/OFFICIAL_ALIGNMENT_PLAN.md](/Users/platojobs/Desktop/Github/flutterffi/PFJSwiftSd/docs/OFFICIAL_ALIGNMENT_PLAN.md)
- [docs/STUDY_SYSTEM_ROADMAP.md](/Users/platojobs/Desktop/Github/flutterffi/PFJSwiftSd/docs/STUDY_SYSTEM_ROADMAP.md)
- [docs/V2_ARCHITECTURE_UPGRADE_PLAN.md](/Users/platojobs/Desktop/Github/flutterffi/PFJSwiftSd/docs/V2_ARCHITECTURE_UPGRADE_PLAN.md)
- [docs/V2_IMPLEMENTATION_SEQUENCE.md](/Users/platojobs/Desktop/Github/flutterffi/PFJSwiftSd/docs/V2_IMPLEMENTATION_SEQUENCE.md)
