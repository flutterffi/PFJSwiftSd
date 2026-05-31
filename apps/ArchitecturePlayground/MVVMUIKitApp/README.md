# MVVMUIKitApp

MVVMUIKitApp is the UIKit-oriented MVVM comparison track.

## Training Goal

Compare UIKit-style MVVM against:

- MVC
- MVP
- SwiftUI MVVM

## What To Observe

- how bindings or callbacks replace controller-heavy mutation
- whether the view model stays clean when the view layer is still imperative
- how easy it is to test formatting and filtering logic

## Current Status

The first scaffold now includes:

- callback-driven list view state
- bookmark and filter actions
- selected lesson state
- detail view-state projection
- weekly summary formatting

This makes UIKit MVVM a stronger comparison point between MVC/MVP and the SwiftUI MVVM track.

## Runnable Demo

You can now run the UIKit MVVM comparison flow directly:

```bash
swift run MVVMUIKitApp
```
