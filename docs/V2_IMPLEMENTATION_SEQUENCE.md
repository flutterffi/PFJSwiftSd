# V2 Implementation Sequence

This page turns the v2 upgrade idea into a practical execution sequence.

## Step 1. Foundations Runner

Goal:

- make `foundations/` runnable from a single command entry point

Deliverables:

- `Sources/FoundationsRunner/`
- lesson registry
- lesson number selection
- `list` command

Success signal:

```bash
swift run FoundationsRunner list
swift run FoundationsRunner 01
```

Current status:

- foundations runner implementation started

## Step 2. Language / Concurrency / Architecture Runners

Goal:

- extend the same model across the non-UI tracks

Deliverables:

- `Sources/LanguageRunner/`
- `Sources/ConcurrencyRunner/`
- `Sources/ArchitectureRunner/`

Success signal:

- one consistent command shape across all runners

## Step 3. Training App Evolution

Goal:

- make `StudyDashboardApp` the visible SwiftUI learning surface

Deliverables:

- course browser section
- demo screen section
- bookmark-only mode
- weekly review sheet

Success signal:

- the user can open the app and discover lessons without hunting through files

## Step 4. Playground Support

Goal:

- keep fast experimentation available without replacing the main structure

Deliverables:

- `Playgrounds/SwiftBasics.playground`
- `Playgrounds/SwiftUIExperiments.playground`

Success signal:

- quick scratch work has a home, but the curriculum still lives in source + app

## Step 5. Curriculum Expansion

Goal:

- fill the official coverage gaps identified in `OFFICIAL_ALIGNMENT_PLAN.md`

Priority additions:

1. control flow
2. functions
3. closures
4. properties
5. initialization
6. Observation
7. searchable and toolbar
8. layout and grid systems

## Recommended Order If Time Is Limited

If only one major change happens next, do this:

1. `FoundationsRunner`

If two major changes happen next, do this:

1. `FoundationsRunner`
2. bookmark-only view in `StudyDashboardApp`
