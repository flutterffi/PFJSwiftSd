# MVVM vs Reducer Comparison

This comparison keeps the lesson feature stable and changes the state-management style.

## MVVM

`MVVMSwiftUIApp` uses:

- reference-type view model
- direct mutation methods
- route and sheet state owned by the view model
- service boundaries around persistence

This style is useful when:

- the team wants low ceremony
- the feature is still modest in size
- direct mutation reads naturally

## Reducer Style

`ReducerStyleApp` uses:

- explicit feature state
- enum-based actions
- a reducer function for mutation
- a store shell that projects view state

This style is useful when:

- state transitions need to stay auditable
- the team wants predictable mutation entry points
- larger features benefit from action logs and explicit state shape

## Stable Parts Across Both

1. filtered lesson results
2. bookmarks-only behavior
3. bookmark toggle meaning
4. detail state after mutation

## Main Design Question

The real question is:

"Does the added action and reducer ceremony buy enough clarity for the feature size and team habits?"

## Practical Rule

Choose MVVM when:

- speed and readability matter more than strict transition boundaries
- the team is comfortable with object-owned state

Choose reducer style when:

- explicit transition points improve confidence
- the feature is likely to grow more complex over time
- test intent reads better as `state + action -> new state`
