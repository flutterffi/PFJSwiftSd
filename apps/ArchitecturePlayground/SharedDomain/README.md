# SharedDomain

SharedDomain contains the reusable business vocabulary for the architecture comparison apps.

This layer should stay as architecture-neutral as possible.

## Shared Concepts

- `Lesson`
- `LessonTrack`
- `LessonFilter`
- `BookmarkState`
- `WeeklyReview`

## Rules

- no UIKit-specific code
- no SwiftUI-specific code
- keep types small and obvious
- prefer plain value types where possible

## Why This Exists

If each architecture app invents different model names and different data shapes, the comparison becomes noisy.

SharedDomain keeps the feature set aligned so the training focus remains on:

- MVC tradeoffs
- MVVM tradeoffs
- MVP tradeoffs
- VIPER tradeoffs

instead of model drift.
