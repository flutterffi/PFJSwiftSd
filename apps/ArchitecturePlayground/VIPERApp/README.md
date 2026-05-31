# VIPERApp

VIPERApp is the high-separation comparison track.

## Training Goal

Split the same feature into:

- View
- Interactor
- Presenter
- Entity
- Router

## What To Observe

- where the separation helps
- where the boilerplate grows
- how module assembly affects complexity
- whether the routing layer improves navigation clarity

## Current Status

The first scaffold now includes:

- view protocol
- router protocol
- interactor with shared lesson data
- presenter-driven list view model generation
- presenter-driven detail view model generation
- filter and bookmark actions routed through the presenter
- compact module builder shell

This makes VIPER a stronger comparison point against MVC and MVP by making role boundaries more explicit.
