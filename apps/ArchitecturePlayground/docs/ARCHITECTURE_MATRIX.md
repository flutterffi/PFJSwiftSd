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
| MVVM (SwiftUI) | observable view model + passive view | scaffolded |
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
