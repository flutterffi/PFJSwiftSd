# MVPApp

MVPApp is the presenter-driven comparison track.

## Training Goal

Split responsibilities into:

- View
- Presenter
- Interactor

and compare that against MVC and MVVM.

## What To Observe

- how passive the view becomes
- how much presenter code grows
- how navigation decisions are represented
- how testing improves when logic moves out of the view layer

## Current Status

The first scaffold includes:

- presenter protocol
- view protocol
- interactor-style lesson source
- list row view models
- detail view model generation
- bookmark and filter presenter actions
- routing protocol for detail navigation

This gives the MVP track a clearer contrast against MVC by moving formatting and interaction flow into the presenter layer.

## Runnable Demo

You can now run the MVP comparison flow directly:

```bash
swift run MVPApp
```
