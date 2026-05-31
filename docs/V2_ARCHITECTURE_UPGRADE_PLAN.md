# PFJSwiftSd v2 Architecture Upgrade Plan

This document defines the next structural upgrade for PFJSwiftSd.

The current repository already works as a strong reading-and-editing practice project. The next version should improve the direct training experience:

- Swift language lessons should be runnable from stable entry points.
- SwiftUI lessons should be visible inside a real app, not only as standalone view files.
- quick experiments should remain easy without replacing the main learning architecture.

## Why Upgrade

The current repository has two limitations:

1. many Swift language lessons are single `.swift` files without a unified runner
2. many SwiftUI lessons are standalone files that require extra setup before they feel like a real course

That means the repository is good for reading, but not yet ideal for repetitive drills and direct feedback loops.

## v2 Design Goals

PFJSwiftSd v2 should make all three workflows easier:

1. run a language lesson quickly
2. open a SwiftUI lesson directly in a visible app flow
3. test a small idea without changing the main project structure

## Recommended v2 System

PFJSwiftSd v2 should use three layers:

### 1. Lesson Source Layer

Keep lesson content as normal source files in the repository.

This keeps lessons:

- readable
- version-controlled
- reusable by runners and apps
- easy to connect to official documentation

Suggested role:

- `foundations/`
- `language/`
- `concurrency/`
- `architecture/`
- `swiftui/`

### 2. Runner Layer

Add executable lesson runners for non-UI topics.

These runners should give direct command-line entry points for:

- foundations
- language
- concurrency
- architecture

Example commands:

```bash
swift run FoundationsRunner 01
swift run FoundationsRunner 05
swift run LanguageRunner 02
swift run ConcurrencyRunner 01
```

Benefits:

- no need to remember file paths
- easy to add a lesson index and challenge mode later
- better learning rhythm than manually compiling random files

### 3. App Layer

Use a real SwiftUI app as the main UI training surface.

The app should become a training shell, not only a project demo.

Recommended direction:

- continue growing `StudyDashboardApp`
- use it as the main SwiftUI training app
- let the app host lesson demos, not only the dashboard project

This app should eventually include:

- lesson catalog
- lesson detail
- bookmark-only mode
- weekly review sheet
- SwiftUI demo screens grouped by topic

### 4. Playground Layer

Keep Playground support only as a lightweight experiment zone.

Suggested role:

- syntax experiments
- throwaway layout tests
- quick API exploration

Playgrounds should not become the main curriculum structure.

## Recommended Folder Model

```text
PFJSwiftSd/
  docs/
  foundations/                  # lesson source
  language/                     # lesson source
  concurrency/                  # lesson source
  architecture/                 # lesson source
  swiftui/                      # lesson source
  projects/
  apps/
    StudyDashboardApp/          # main SwiftUI training app
  Lessons/
    Foundations/
    Language/
    Concurrency/
    Architecture/
  Sources/
    FoundationsRunner/
    LanguageRunner/
    ConcurrencyRunner/
    ArchitectureRunner/
  Playgrounds/
    SwiftBasics.playground
    SwiftUIExperiments.playground
```

## How Existing Content Maps Into v2

### Current `foundations/`, `language/`, `concurrency/`, `architecture/`

Keep these as the source-of-truth lesson folders.

Do not delete or hide them.

Instead:

- connect them to runners
- add metadata or simple indexing later
- preserve the file-per-lesson teaching style

### Current `swiftui/`

Keep the lesson files, but stop treating them as the final user experience.

Instead:

- connect them to app screens
- reuse their ideas in `StudyDashboardApp`
- let the app become the visible training surface

### Current `StudyDashboardApp`

This should evolve into the main training app shell.

Do not replace it with a separate parallel app unless the scope grows too large.

Recommended direction:

- dashboard remains the integration project
- lesson list becomes a course browser
- SwiftUI topic demos live behind app navigation

### Current `projects/01_study_dashboard_app`

Keep this as the feature-core and architecture training track.

This project should continue to demonstrate:

- state management
- persistence
- filtering
- async loading
- testing

## Runner Design Suggestion

Each runner should do three jobs:

1. list lessons
2. run one lesson
3. optionally show a challenge prompt

Simple examples:

```bash
swift run FoundationsRunner list
swift run FoundationsRunner 01
swift run FoundationsRunner 01 --challenge
```

The first version can stay small:

- hard-coded lesson registry
- print lesson names
- call the lesson entry function

## App Design Suggestion

`StudyDashboardApp` should gradually become:

### Section 1. Course

- Foundations
- Language
- Concurrency
- SwiftUI

### Section 2. Demos

- State and Binding
- Lists and ForEach
- NavigationStack
- Async ViewModel
- Searchable UI

### Section 3. Project

- Dashboard
- Bookmarks
- Lesson Detail
- Weekly Review

This keeps the app useful for both:

- lesson discovery
- real feature practice

## Why Not Make Playground The Main System

Playgrounds are helpful, but they are not the best backbone for a long-lived training repository.

Main limitations:

- weaker structure for a large curriculum
- less natural connection to tests and modules
- weaker fit for real SwiftUI feature architecture
- less stable as the main evolution path of the repository

Best use:

- auxiliary experiments only

## Migration Plan

### Phase A

Add runner targets without deleting current lesson files.

Priority:

1. `FoundationsRunner`
2. `LanguageRunner`
3. `ConcurrencyRunner`
4. `ArchitectureRunner`

### Phase B

Expand `StudyDashboardApp` into a course app shell.

Priority:

1. bookmark-only view
2. weekly review sheet
3. lesson catalog section
4. SwiftUI demo section

### Phase C

Add small Playgrounds for quick experiments.

Priority:

1. `SwiftBasics.playground`
2. `SwiftUIExperiments.playground`

## First Recommended Implementation Step

The best first code change for v2 is:

1. create `FoundationsRunner`
2. make it able to run lessons by number
3. prove the runner pattern before duplicating it for other tracks

Why this is the best first step:

- low risk
- high practical value
- immediately improves the training experience
- gives a reusable pattern for all later non-UI tracks
