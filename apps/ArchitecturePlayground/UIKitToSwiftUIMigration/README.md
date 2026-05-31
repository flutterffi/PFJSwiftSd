# UIKitToSwiftUIMigration

UIKitToSwiftUIMigration is the dedicated training topic for moving an existing UIKit feature into SwiftUI without changing the business scope.

## Training Goal

Practice migration as a sequence:

1. keep the shared lesson domain stable
2. compare UIKit MVVM and SwiftUI MVVM behavior
3. move navigation and view state step by step
4. decide when to stop at `ObservableObject`
5. decide when `@Observable` is worth the extra platform assumptions

## Recommended Comparison Path

1. `MVVMUIKitApp`
2. `MVVMSwiftUIApp`
3. `ObservationMVVMApp`

This path keeps the feature set stable while the UI technology and state wiring change.

## What To Compare

- query and filter behavior
- bookmark toggle behavior
- detail navigation shape
- weekly review presentation
- persistence boundary
- error state exposure

## Verification

Migration-focused tests live in:

- `Tests/UIKitSwiftUIMigrationTests/UIKitSwiftUIMigrationTests.swift`

Run them like this:

```bash
swift test --filter UIKitSwiftUIMigrationTests
```

## Main References

- [UIKIT_SWIFTUI_MIGRATION_PLAYBOOK.md](/Users/platojobs/Desktop/Github/flutterffi/PFJSwiftSd/apps/ArchitecturePlayground/docs/UIKIT_SWIFTUI_MIGRATION_PLAYBOOK.md)
- [COMPARISON_CHECKLIST.md](/Users/platojobs/Desktop/Github/flutterffi/PFJSwiftSd/apps/ArchitecturePlayground/docs/COMPARISON_CHECKLIST.md)
