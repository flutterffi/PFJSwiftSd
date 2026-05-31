# UIKit vs SwiftUI Migration Playbook

This playbook treats migration as a training exercise instead of a rewrite fantasy.

## Recommended Rule

Migrate one concern at a time:

1. domain model
2. feature state
3. filtering and search
4. bookmark mutation
5. detail navigation
6. secondary presentation like weekly review
7. persistence

## Stable Scope

Keep the same feature in every migration step:

1. lesson list
2. search and filtering
3. bookmark toggle
4. lesson detail
5. weekly review

## Training Stages

### Stage 1

Read `MVVMUIKitApp` and identify:

- where the controller would still exist
- which callback updates the view
- where selection becomes detail state

### Stage 2

Read `MVVMSwiftUIApp` and map:

- callback-driven list state to direct SwiftUI bindings
- selected lesson state to navigation path state
- imperative refresh to reactive rendering

### Stage 3

Read `ObservationMVVMApp` and compare:

- `ObservableObject` boilerplate
- route and sheet state ownership
- what became simpler
- what still needs service boundaries

## Migration Questions

- Which UIKit state can become derived SwiftUI state immediately?
- Which mutation rules should stay in a service instead of moving into the view?
- Which navigation flows are safer to migrate after business behavior is already covered by tests?
- Does the team need `@Observable`, or is `ObservableObject` sufficient for deployment targets and code clarity?

## Good Output

A good migration keeps these stable:

- filtering results
- bookmark persistence behavior
- detail content
- weekly summary values

Only the UI technology and state wiring should change.
