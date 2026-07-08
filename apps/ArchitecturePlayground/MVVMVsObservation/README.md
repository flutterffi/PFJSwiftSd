# MVVMVsObservation

MVVMVsObservation is the dedicated comparison topic for classic SwiftUI MVVM with `ObservableObject` versus the newer Observation-based model flow.

## Training Goal

Keep the lesson feature stable and compare:

1. where state lives
2. how much publishing boilerplate exists
3. how navigation state is expressed
4. how persistence boundaries stay the same
5. how tests change when the state container changes

## Suggested Study Order

1. `MVVMSwiftUIApp`
2. `ObservationMVVMApp`
3. `docs/MVVM_OBSERVATION_COMPARISON.md`

## What To Compare

- query filtering
- bookmarks-only mode
- bookmark toggle behavior
- bookmarks route behavior
- route updates for lesson detail
- weekly review presentation
- load/save error messaging
- persisted bookmark loading

## Verification

Comparison-focused tests live in:

- `Tests/MVVMObservationComparisonTests/MVVMObservationComparisonTests.swift`

Run them like this:

```bash
swift test --filter MVVMObservationComparisonTests
```
