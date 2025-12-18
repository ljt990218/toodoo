# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Build Commands

```bash
# Build the app
xcodebuild -scheme toodoo -destination 'platform=iOS Simulator,name=iPhone 16' build

# Run unit tests
xcodebuild -scheme toodoo -destination 'platform=iOS Simulator,name=iPhone 16' test

# Run UI tests
xcodebuild -scheme toodooUITests -destination 'platform=iOS Simulator,name=iPhone 16' test
```

## Architecture

This is a SwiftUI iOS app using SwiftData for persistence.

- **toodooApp.swift**: App entry point, configures the SwiftData ModelContainer with the `Item` schema
- **ContentView.swift**: Main UI with NavigationSplitView, displays items in a list with add/delete functionality
- **Item.swift**: SwiftData `@Model` class with a single `timestamp` property

## Key Patterns

- Uses `@Environment(\.modelContext)` for data operations
- Uses `@Query` for reactive data fetching
- Swift 6 concurrency mode enabled with `SWIFT_DEFAULT_ACTOR_ISOLATION = MainActor`
- Unit tests use Swift Testing framework (`import Testing`, `@Test`)
- Deployment target: iOS 26.0
