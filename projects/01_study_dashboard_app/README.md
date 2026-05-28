# Study Dashboard App

This project is the first larger SwiftUI training direction in PFJSwiftSd.

## Goal

Build a small learning dashboard app that helps a user:

- browse Swift and SwiftUI lessons
- review progress by category
- filter lessons by track
- load remote or mocked study metrics
- navigate from dashboard to lesson detail and milestone views

## Suggested Feature Breakdown

1. Dashboard screen
2. Lesson detail screen
3. Weekly review sheet
4. Async metrics loading
5. Local persistence for bookmarks

## Implemented Training Feature

The repository now includes a runnable Swift dashboard example:

1. `study_dashboard_feature.swift`

This example demonstrates:

- async lesson loading
- track filtering
- search query filtering
- bookmark toggling
- bookmark persistence with a JSON file
- reducer-style state updates

Run it like this:

```bash
swiftc \
  projects/01_study_dashboard_app/domain/LessonModels.swift \
  projects/01_study_dashboard_app/domain/DashboardStore.swift \
  projects/01_study_dashboard_app/persistence/BookmarkPersistence.swift \
  projects/01_study_dashboard_app/support/SampleData.swift \
  projects/01_study_dashboard_app/study_dashboard_feature.swift \
  -o .build/study_dashboard_feature

./.build/study_dashboard_feature
```

## Verification

The project now has runnable test-style files:

1. `tests/dashboard_store_tests.swift`
2. `tests/bookmark_persistence_tests.swift`

Run them like this:

```bash
swiftc \
  projects/01_study_dashboard_app/domain/LessonModels.swift \
  projects/01_study_dashboard_app/domain/DashboardStore.swift \
  projects/01_study_dashboard_app/persistence/BookmarkPersistence.swift \
  projects/01_study_dashboard_app/support/SampleData.swift \
  projects/01_study_dashboard_app/tests/dashboard_store_tests.swift \
  -o .build/dashboard_store_tests

./.build/dashboard_store_tests

swiftc \
  projects/01_study_dashboard_app/domain/LessonModels.swift \
  projects/01_study_dashboard_app/persistence/BookmarkPersistence.swift \
  projects/01_study_dashboard_app/tests/bookmark_persistence_tests.swift \
  -o .build/bookmark_persistence_tests

./.build/bookmark_persistence_tests
```

## SwiftUI App Shell

The reusable dashboard core now also powers a minimal macOS SwiftUI shell:

```bash
swift build --product StudyDashboardApp
swift run StudyDashboardApp
```

## Good Architecture Practice

- keep domain models independent from views
- isolate async loading in a view model or store
- use enums for routes and loading state
- make preview data easy to inject

## Practice Expansion Ideas

- add search
- add a streak widget
- move from `ObservableObject` to the Observation system
- persist bookmarks with `UserDefaults` or SwiftData
- add tests around reducer or view-model behavior
