# MVVMVsCoordinator

MVVMVsCoordinator is the dedicated comparison topic for classic SwiftUI MVVM and coordinator-oriented navigation.

## Training Goal

Keep the lesson feature stable and compare:

1. view-model-owned navigation versus coordinator-owned navigation
2. route updates after mutation
3. weekly review presentation intent
4. how list state projection changes when navigation leaves the view model
5. whether navigation tests read more clearly

## Suggested Study Order

1. `MVVMSwiftUIApp`
2. `CoordinatorMVVMApp`
3. `docs/MVVM_COORDINATOR_COMPARISON.md`

## What To Compare

- query filtering
- bookmarks-only mode
- detail navigation ownership
- bookmark toggle after detail navigation
- weekly review intent

## Verification

Run these:

```bash
swift run CoordinatorMVVMApp
swift test --filter CoordinatorMVVMAppTests
swift test --filter MVVMCoordinatorComparisonTests
```
