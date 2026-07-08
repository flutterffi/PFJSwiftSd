# MVVM vs Observation Comparison

This comparison keeps the same lesson feature and changes only the state container style.

## Classic SwiftUI MVVM

`MVVMSwiftUIApp` uses:

- `ObservableObject`
- `@Published`
- an explicit view model type
- a passive SwiftUI view

This style is useful when:

- the team already understands `ObservableObject`
- deployment targets or codebase conventions favor established patterns
- explicit publishing calls help readability for the team

## Observation-Based Flow

`ObservationMVVMApp` uses:

- `@Observable`
- mutable model state without `@Published`
- `@Bindable` in the view
- the same service and persistence boundary

This style is useful when:

- the app can rely on modern platform targets
- the team wants less publishing boilerplate
- the model itself can cleanly own route, sheet, and filter state

## Stable Parts Across Both

These should not change during the comparison:

1. filtered lesson results
2. bookmarks-only behavior
3. bookmark persistence behavior
4. detail route updates
5. weekly review values
6. load/save error semantics

## Main Design Question

The real question is not "Which is newer?"

It is:

"Does reducing publishing boilerplate make the feature clearer for this team, without hiding ownership boundaries?"

## Practical Rule

Choose `ObservableObject` when:

- the explicitness helps onboarding
- the team already has strong MVVM habits
- compatibility and predictability matter more than reducing annotations

Choose Observation when:

- deployment targets already allow it
- route, sheet, and filter state fit naturally into one observable model
- the team wants fewer reactive wrappers around plain state

## Test-Driven Comparison Rule

Before changing UI structure, keep these comparison tests green:

1. query filtering parity
2. bookmarks-only parity
3. detail route update parity
4. bookmarks route parity
5. weekly review intent parity
6. load/save error parity
7. persisted bookmark load parity
