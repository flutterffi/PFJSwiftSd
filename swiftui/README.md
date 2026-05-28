# SwiftUI

The `swiftui/` folder moves from view composition into feature-level UI design.

Suggested order:

1. `00_view_composition_and_modifiers.swift`
2. `00_lists_and_identifiable.swift`
3. `01_state_lifecycle.swift`
4. `02_navigation_and_routing.swift`
5. `03_async_view_model.swift`

Focus on these ideas while practicing:

- compose screens from small views
- extract repeated styling into modifiers
- let models drive `List` and `ForEach`
- choose the right state owner
- keep async UI updates on the main actor
- model navigation with data instead of ad hoc booleans

Good edits to try:

- add a second custom modifier
- group lessons into sections
- add a selected row state
- push from the list into a detail screen
- show an error state in the async example
