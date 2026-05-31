# MVCApp

MVCApp will be the first UIKit-oriented comparison target.

## Training Goal

Use a classic Model-View-Controller structure to implement the shared feature set.

## What To Observe

- how quickly the controller grows
- how filtering and bookmark logic gets distributed
- how navigation is coordinated
- how hard it is to test view-controller-heavy behavior

## Suggested Folder Shape

```text
MVCApp/
  Models/
  Views/
  Controllers/
  Services/
```

## First Implementation Scope

1. lesson list screen
2. search/filter
3. bookmark toggle
4. lesson detail push

## Current Status

The first scaffold now includes a controller-style training shell:

- `Sources/MVCLessonController.swift`

This now covers:

- list view state preparation
- bookmark count and weekly summary formatting
- bookmark mutations
- detail selection and router handoff
- detail view state preparation

That makes the MVC track a stronger contrast against the existing MVVM SwiftUI implementation.

## Runnable Demo

You can now run the MVC comparison flow directly:

```bash
swift run MVCApp
```
