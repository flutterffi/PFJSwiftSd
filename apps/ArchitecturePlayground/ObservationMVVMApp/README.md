# ObservationMVVMApp

ObservationMVVMApp is the modern SwiftUI comparison track using the Observation system.

## Training Goal

Compare Observation-based state management against the older `ObservableObject`-style MVVM flow.

## What To Observe

- how model mutation becomes simpler
- how much view boilerplate disappears
- whether the data flow feels clearer than classic MVVM

## Current Status

The stronger Observation version now includes:

- observation-based lesson model
- searchable list view
- bookmark toggling
- weekly summary strip
- lesson detail navigation
- dedicated bookmarks screen
- bookmark persistence abstraction
- route and sheet state in the model
- load and save error messaging
- dedicated XCTest coverage

This now makes the Observation track a stronger direct comparison against the older `ObservableObject` MVVM variant.

## Verification

Observation-specific tests now live in:

- `Tests/ObservationMVVMAppTests/ObservationLessonServiceTests.swift`
- `Tests/ObservationMVVMAppTests/ObservationLessonModelTests.swift`

Run them like this:

```bash
swift test --filter ObservationMVVMAppTests
```

## Recommended Study Order

1. read `ObservationLessonModel.swift` to see how state, routes, sheets, and errors stay in one observable model
2. inspect `ObservationLessonService.swift` and `ObservationBookmarkPersistence.swift`
3. compare `ObservationLessonListView.swift` with the classic `MVVMLessonListView.swift`
4. compare `ObservationMVVMApp` against `MVVMSwiftUIApp` and note which boilerplate actually disappeared
