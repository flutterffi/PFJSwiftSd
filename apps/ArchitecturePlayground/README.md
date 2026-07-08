# ArchitecturePlayground

ArchitecturePlayground is the comparison-training area for app architectures in PFJSwiftSd.

The core idea is simple:

- use the same feature requirements
- implement them with different architectures
- compare structure, navigation, state flow, and testing tradeoffs

## Shared Training Feature Set

Every architecture variant should aim to support the same learning scope:

1. lesson list
2. search and filtering
3. bookmark toggle
4. lesson detail
5. weekly review summary

This keeps the comparison focused on architecture instead of changing product scope.

## Recommended Architecture Tracks

### UIKit-oriented comparison

- MVC
- MVP
- MVVM (UIKit)
- VIPER

### SwiftUI-oriented comparison

- MVVM (SwiftUI)
- Observation-based MVVM
- Coordinator + MVVM
- reducer-style or TCA-style flow

## Migration Topic

There is now a dedicated `UIKitToSwiftUIMigration/` topic for comparing how the same feature moves from `MVVMUIKitApp` into `MVVMSwiftUIApp` and then into `ObservationMVVMApp`.

## SwiftUI State Topic

There is also a dedicated `MVVMVsObservation/` topic for comparing classic `ObservableObject` MVVM against `@Observable`-based state with the same shared feature.

## Reducer Topic

There is now a dedicated `MVVMVsReducer/` topic for comparing classic MVVM against explicit reducer-style state management with the same lesson feature.

## Coordinator Topic

There is now a dedicated `MVVMVsCoordinator/` topic for comparing classic MVVM against coordinator-owned navigation with the same lesson feature.

## Folder Structure

```text
ArchitecturePlayground/
  SharedDomain/
  MVCApp/
  MVPApp/
  MVVMUIKitApp/
  MVVMSwiftUIApp/
  VIPERApp/
  ObservationMVVMApp/
  CoordinatorMVVMApp/
  ReducerStyleApp/
  docs/
```

The first phase starts with:

- `SharedDomain`
- `MVCApp`
- `MVVMSwiftUIApp`

These give a strong contrast without making the repository too large too early.

The broader comparison set is now scaffolded so the repository can grow architecture training incrementally instead of reinventing each track later.

The UIKit group is now runnable from Terminal as four separate demo targets:

- `swift run MVCApp`
- `swift run MVPApp`
- `swift run MVVMUIKitApp`
- `swift run VIPERApp`
- `swift run ReducerStyleApp`
- `swift run CoordinatorMVVMApp`

## Comparison Questions

Every architecture variant should help answer:

1. where does state live?
2. how does navigation work?
3. how are dependencies injected?
4. how hard is testing?
5. what grows painful first?

## Verification

UIKit architecture comparison tests now live in:

- `Tests/UIKitArchitectureComparisonTests/`

Run them like this:

```bash
swift test --filter UIKitArchitectureComparisonTests
swift test --filter UIKitSwiftUIMigrationTests
swift test --filter MVVMObservationComparisonTests
swift test --filter ReducerStyleAppTests
swift test --filter MVVMReducerComparisonTests
swift test --filter CoordinatorMVVMAppTests
swift test --filter MVVMCoordinatorComparisonTests
```

## Good Expansion Rule

Add a new architecture only when:

- it reuses the shared feature set
- it documents the tradeoffs clearly
- it adds a real comparison value

## Current Phase

This directory currently defines the training structure and the shared domain model.

If you want one starting point instead of the whole matrix, begin with `MVVMSwiftUIApp`.
It currently has the strongest mix of shared domain reuse, SwiftUI flow, service abstraction,
navigation state, bookmarks navigation, persistence, weekly review UI, and dedicated tests.

The next implementation step should be:

1. compare the strengthened `MVVMSwiftUIApp` against `ObservationMVVMApp`
2. compare the strengthened `ReducerStyleApp` against MVVM and MVC
3. compare the strengthened `CoordinatorMVVMApp` against plain SwiftUI MVVM and reducer-style navigation
4. compare the strengthened `MVCApp`, `MVPApp`, `MVVMUIKitApp`, and `VIPERApp` as a UIKit progression set
5. use `MVVMVsObservation/` to compare classic MVVM and Observation with a stable feature and test baseline
