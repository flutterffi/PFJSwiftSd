# MVVM vs Coordinator Comparison

This comparison keeps the lesson feature stable and changes where navigation decisions live.

## Plain MVVM

`MVVMSwiftUIApp` uses:

- a view model that owns route state
- detail and sheet intent created directly from the view model
- feature logic and navigation state in one object

This style is useful when:

- the feature is still compact
- navigation does not yet justify a separate object
- fewer layers help the team move quickly

## Coordinator-Oriented Flow

`CoordinatorMVVMApp` uses:

- a coordinator that owns route state
- list projection and navigation intent in one routing object
- a clearer split between screen state and navigation state

This style is useful when:

- navigation flows become more central
- route testing matters
- screen construction starts growing beyond a single feature object

## Stable Parts Across Both

1. filtered lesson results
2. bookmarks-only behavior
3. bookmark toggle meaning
4. detail intent after mutation
5. weekly review intent

## Main Design Question

The real question is:

"Has navigation complexity grown enough that a dedicated coordinator makes the feature easier to reason about?"

## Practical Rule

Choose plain MVVM when:

- navigation is still small
- one feature object is easier for the team to follow

Choose coordinator-oriented navigation when:

- route ownership deserves explicit structure
- testing route behavior separately becomes valuable
