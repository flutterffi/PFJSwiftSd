# MVVMVsReducer

MVVMVsReducer is the dedicated comparison topic for classic SwiftUI MVVM and reducer-style feature state.

## Training Goal

Keep the lesson feature stable and compare:

1. object-driven mutation versus action-driven mutation
2. implicit UI refresh versus explicit state transitions
3. how navigation intent stays represented
4. how much ceremony improves traceability
5. how tests read when state is explicit

## Suggested Study Order

1. `MVVMSwiftUIApp`
2. `ReducerStyleApp`
3. `docs/MVVM_REDUCER_COMPARISON.md`

## What To Compare

- query filtering
- bookmarks-only mode
- bookmark toggle behavior
- detail intent after bookmark mutation
- test readability

## Verification

Run these:

```bash
swift run ReducerStyleApp
swift test --filter ReducerStyleAppTests
swift test --filter MVVMReducerComparisonTests
```
