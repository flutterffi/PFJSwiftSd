# Official Alignment Plan

This document turns PFJSwiftSd into a more official-aligned learning system.

The repository already works well as a practice-first training project. The next goal is to make the learning path easier to compare with the official Swift.org language guide and Apple SwiftUI documentation.

## Status Labels

- `Covered`
  The repository already has focused lessons for this topic.
- `Partial`
  The topic appears in lessons or projects, but not yet as a full learning unit.
- `Missing`
  The topic should be added if the repository wants stronger official coverage.

## Swift Language Alignment

### Stage 1. Core Syntax

- The Basics: `Covered`
- Basic Operators: `Missing`
- Strings and Characters: `Missing`
- Collection Types: `Covered`
- Control Flow: `Missing`
- Functions: `Partial`
- Closures: `Missing`

Current repository fit:

- `foundations/01_constants_variables_and_interpolation.swift`
- `foundations/02_optionals_guard_and_nil_coalescing.swift`
- `foundations/04_collection_transformations.swift`

Suggested additions:

1. `foundations/05_control_flow_and_switch.swift`
2. `foundations/06_functions_and_parameter_labels.swift`
3. `foundations/07_closures_and_sorting.swift`
4. `foundations/08_strings_numbers_and_formatting.swift`
5. `foundations/09_basic_operators_and_ranges.swift`

### Stage 2. Type Modeling

- Enumerations: `Covered`
- Structures and Classes: `Partial`
- Properties: `Missing`
- Methods: `Covered`
- Subscripts: `Missing`
- Inheritance: `Missing`
- Initialization: `Missing`
- Deinitialization: `Missing`
- Optional Chaining: `Missing`

Current repository fit:

- `foundations/03_enums_structs_and_methods.swift`
- `language/01_value_semantics_and_copy_on_write.swift`

Suggested additions:

1. `foundations/10_structs_vs_classes.swift`
2. `foundations/11_stored_and_computed_properties.swift`
3. `foundations/12_initializers_and_memberwise_design.swift`
4. `language/03_optional_chaining_and_nested_models.swift`
5. `language/04_subscripts_and_small_data_structures.swift`

### Stage 3. Safety and Error Handling

- Error Handling: `Missing`
- Assertions and Preconditions: `Missing`
- Access Control: `Missing`
- Memory Safety: `Missing`
- Automatic Reference Counting: `Missing`

Suggested additions:

1. `foundations/13_error_handling_basics.swift`
2. `language/05_access_control_and_module_thinking.swift`
3. `language/06_arc_and_reference_cycles.swift`
4. `engineering/01_assertions_preconditions_and_debugging.swift`

### Stage 4. Abstraction and Reuse

- Protocols: `Covered`
- Generics: `Covered`
- Opaque and Boxed Types: `Partial`
- Extensions: `Partial`
- Nested Types: `Missing`
- Macros: `Missing`

Current repository fit:

- `language/02_protocols_generics_and_type_erasure.swift`

Suggested additions:

1. `language/07_extensions_and_protocol_composition.swift`
2. `language/08_nested_types_and_domain_namespacing.swift`
3. `language/09_opaque_types_and_view_style_thinking.swift`
4. `language/10_macro_awareness_and_modern_swift_notes.swift`

### Stage 5. Modern Concurrency

- Concurrency: `Covered`

Current repository fit:

- `concurrency/01_async_await_and_task_group.swift`

Suggested additions:

1. `concurrency/02_actors_and_isolation.swift`
2. `concurrency/03_task_cancellation_patterns.swift`
3. `concurrency/04_async_sequence_basics.swift`
4. `concurrency/05_main_actor_ui_coordination.swift`

## SwiftUI Alignment

### Stage 1. App Structure and Views

- SwiftUI app entry: `Partial`
- View protocol and composition: `Covered`
- Text, images, stacks, containers: `Partial`
- Modifiers: `Covered`
- Preview workflow: `Partial`

Current repository fit:

- `swiftui/00_view_composition_and_modifiers.swift`
- `apps/StudyDashboardApp/`

Suggested additions:

1. `swiftui/04_layout_stacks_grids_and_spacing.swift`
2. `swiftui/05_images_icons_and_content_style.swift`
3. `swiftui/06_preview_patterns_and_mock_data.swift`

### Stage 2. Data Flow

- State: `Covered`
- Binding: `Covered`
- ObservableObject: `Covered`
- Observation system: `Missing`
- Environment and dependency flow: `Missing`

Current repository fit:

- `swiftui/01_state_lifecycle.swift`
- `swiftui/03_async_view_model.swift`

Suggested additions:

1. `swiftui/07_observation_system_basics.swift`
2. `swiftui/08_environment_and_shared_dependencies.swift`
3. `swiftui/09_forms_inputs_and_focus.swift`

### Stage 3. Collections and Navigation

- List and ForEach: `Covered`
- NavigationStack: `Covered`
- Sheet presentation: `Covered`
- Search: `Partial`
- Toolbar and commands: `Missing`

Current repository fit:

- `swiftui/00_lists_and_identifiable.swift`
- `swiftui/02_navigation_and_routing.swift`
- `apps/StudyDashboardApp/Sources/DashboardView.swift`

Suggested additions:

1. `swiftui/10_searchable_and_filter_patterns.swift`
2. `swiftui/11_toolbar_and_actions.swift`
3. `swiftui/12_navigation_path_and_route_enums.swift`

### Stage 4. Animation and Advanced UI

- Animations: `Missing`
- Transitions: `Missing`
- Gesture basics: `Missing`
- Custom reusable components: `Partial`

Suggested additions:

1. `swiftui/13_animation_basics.swift`
2. `swiftui/14_transitions_and_conditional_content.swift`
3. `swiftui/15_gestures_and_interaction.swift`
4. `swiftui/16_reusable_view_components.swift`

## App Track Alignment

The app track should become the integration layer for all lessons.

Current state:

- `StudyDashboardApp` already covers dashboard rendering, filtering, bookmark toggling, and lesson detail navigation.

Recommended next app milestones:

1. bookmark-only view
2. weekly review sheet
3. route enum for app navigation
4. observation-based model variant
5. local persistence upgrade

## Recommended Build Order

If you want to strengthen official alignment without exploding scope, use this order:

1. fill missing Swift foundations
2. fill missing Swift type-modeling chapters
3. add SwiftUI data-flow chapters
4. add SwiftUI layout and search chapters
5. expand the app track to exercise the new lessons
