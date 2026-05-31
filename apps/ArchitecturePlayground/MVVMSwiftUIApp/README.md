# MVVMSwiftUIApp

MVVMSwiftUIApp will be the first SwiftUI-oriented comparison target.

## Training Goal

Use a modern SwiftUI + MVVM structure to implement the shared feature set.

## What To Observe

- how state is split between view and view model
- how filtering and bookmarks stay testable
- how navigation remains readable
- how much boilerplate is needed compared with MVC

## Suggested Folder Shape

```text
MVVMSwiftUIApp/
  Views/
  ViewModels/
  Models/
  Services/
```

## First Implementation Scope

1. lesson list screen
2. search/filter
3. bookmark toggle
4. lesson detail navigation

## Current Status

The first scaffold now exists with:

- shared sample domain data
- view model based filtering
- bookmark toggling
- lesson detail navigation
