# MVVMSwiftUIApp

MVVMSwiftUIApp will be the first SwiftUI-oriented comparison target.

## Training Goal

Use a modern SwiftUI + MVVM structure to implement the shared feature set.

## What To Observe

- how state is split between view and view model
- how filtering and bookmarks stay testable
- how navigation remains readable
- how much boilerplate is needed compared with MVC

## Suggested Folder Shape

```text
MVVMSwiftUIApp/
  Views/
  ViewModels/
  Models/
  Services/
```

## First Implementation Scope

1. lesson list screen
2. search/filter
3. bookmark toggle
4. lesson detail navigation

## Current Status

The first scaffold now exists with:

- shared sample domain data
- view model based filtering
- bookmark toggling
- lesson detail navigation

The stronger MVVM version now also includes:

- service abstraction
- route enum driven navigation
- weekly review sheet
- bookmark-only workflow through view-model-owned filters

## Verification

MVVM-specific tests now live in:

- `Tests/MVVMSwiftUIAppTests/MVVMLessonServiceTests.swift`
- `Tests/MVVMSwiftUIAppTests/MVVMLessonListViewModelTests.swift`

Run them like this:

```bash
swift test --filter MVVMSwiftUIAppTests
```

If SwiftPM is blocked in a restricted sandbox, run the same command in a normal local Terminal session on macOS.

## Recommended Study Order

1. read `MVVMLessonService.swift` to see where lesson loading and bookmark mutation live
2. read `MVVMLessonListViewModel.swift` to follow filter, route, and sheet state
3. open `MVVMLessonListView.swift` and trace how the view stays passive
4. compare this target with `ObservationMVVMApp` and `ReducerStyleApp`
