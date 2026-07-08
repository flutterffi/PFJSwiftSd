# CoordinatorMVVMApp

CoordinatorMVVMApp is the route-oriented comparison track.

## Training Goal

Compare plain SwiftUI navigation against an explicit coordinator layer.

## What To Observe

- how route enums centralize navigation
- how screen creation is coordinated
- whether testability improves when navigation leaves the view

## Current Status

The first scaffold now includes:

- route enum
- lesson list view-state projection
- query, track, and bookmark filter handling
- detail route updates
- weekly review route support
- detail and review view-state projection

This makes the coordinator track a stronger comparison point for navigation organization inside SwiftUI-oriented architectures.

## Runnable Demo

You can now run the coordinator comparison flow directly:

```bash
swift run CoordinatorMVVMApp
```

## Verification

Coordinator-specific tests now live in:

- `Tests/CoordinatorMVVMAppTests/`

Run them like this:

```bash
swift test --filter CoordinatorMVVMAppTests
```
