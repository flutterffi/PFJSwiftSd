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

## Comparison Questions

Every architecture variant should help answer:

1. where does state live?
2. how does navigation work?
3. how are dependencies injected?
4. how hard is testing?
5. what grows painful first?

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
5. deepen MVVM with more service and test coverage if it becomes the main learning path
