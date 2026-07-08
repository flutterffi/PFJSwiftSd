# Architecture Matrix

This matrix tracks the intended comparison set for ArchitecturePlayground.

## UIKit-Oriented Tracks

| Architecture | Focus | Current Status |
| --- | --- | --- |
| MVC | controller-driven flow | runnable demo + tests |
| MVP | presenter-driven flow | runnable demo + tests |
| MVVM (UIKit) | view model over UIKit-style state updates | runnable demo + tests |
| VIPER | highly separated responsibilities | runnable demo + tests |

## SwiftUI-Oriented Tracks

| Architecture | Focus | Current Status |
| --- | --- | --- |
| MVVM (SwiftUI) | observable view model + passive view | strengthened scaffold + tests |
| Observation MVVM | modern Observation-based flow | strengthened scaffold + tests |
| Coordinator + MVVM | route and navigation coordination | strengthened scaffold |
| Reducer Style | action/state driven feature updates | strengthened scaffold |

## Shared Feature Set

Every architecture should eventually express the same feature scope:

1. lesson list
2. search and filtering
3. bookmark toggle
4. lesson detail
5. weekly review

## Migration Topic

Use `UIKitToSwiftUIMigration/` when the goal is not only to compare architectures, but to practice how a stable UIKit feature can be moved into SwiftUI step by step.

## SwiftUI State Topic

Use `MVVMVsObservation/` when the goal is to compare two modern SwiftUI state-container styles without changing the feature scope.

## Current Recommended Starting Track

Start with `MVVM (SwiftUI)` if you want the most balanced first comparison target.
It currently has the clearest combination of:

1. shared feature coverage
2. route and sheet handling
3. service abstraction
4. bookmark persistence and dedicated bookmarks flow
5. dedicated XCTest coverage
