# Architecture Matrix

This matrix tracks the intended comparison set for ArchitecturePlayground.

## UIKit-Oriented Tracks

| Architecture | Focus | Current Status |
| --- | --- | --- |
| MVC | controller-driven flow | scaffolded |
| MVP | presenter-driven flow | strengthened scaffold |
| MVVM (UIKit) | view model over UIKit-style state updates | strengthened scaffold |
| VIPER | highly separated responsibilities | strengthened scaffold |

## SwiftUI-Oriented Tracks

| Architecture | Focus | Current Status |
| --- | --- | --- |
| MVVM (SwiftUI) | observable view model + passive view | strengthened scaffold + tests |
| Observation MVVM | modern Observation-based flow | strengthened scaffold |
| Coordinator + MVVM | route and navigation coordination | strengthened scaffold |
| Reducer Style | action/state driven feature updates | strengthened scaffold |

## Shared Feature Set

Every architecture should eventually express the same feature scope:

1. lesson list
2. search and filtering
3. bookmark toggle
4. lesson detail
5. weekly review

## Current Recommended Starting Track

Start with `MVVM (SwiftUI)` if you want the most balanced first comparison target.
It currently has the clearest combination of:

1. shared feature coverage
2. route and sheet handling
3. service abstraction
4. dedicated XCTest coverage
