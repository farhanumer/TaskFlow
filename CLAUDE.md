# TaskFlow — Agent Guide

## Project

Native iOS app (Swift 6.1+, SwiftUI, iOS 17+ deployment target). Workspace + SPM package layout:

- `TaskFlow/` — app target, just the `@main` entry point (`TaskFlowApp.swift`) and `Assets.xcassets`.
- `TaskFlowPackage/Sources/TaskFlowFeature/` — all feature code (views, models) goes here.
- `TaskFlowPackage/Tests/TaskFlowFeatureTests/` — tests, using **Swift Testing** (`@Test`, `#expect`), not XCTest.

Follow the existing MV pattern already used in this package: no ViewModels, state lives directly in views via `@State`/`@Binding`, plain structs/enums for models.

## Tooling — always go through the skills

- **Linear** (issues/tasks): use the `linear-cli` skill. Project: **"Claude Code Demo"** (team `FAR`). Check it first for pending work:
  ```bash
  linear issue query --project "Claude Code Demo" --team FAR --json
  ```
- **Xcode build/test/simulator work**: use the `xcodebuildmcp-cli` skill (help-first discovery via `xcodebuildmcp <workflow> <tool> --help`). Don't hand-write `xcodebuild`/`xcrun`/`simctl`. Workspace: `TaskFlow.xcworkspace`, scheme: `TaskFlow`, simulator: "iPhone 17".
- **GitHub** (PRs/issues): use the `gh` skill. Repo: `farhanumer/TaskFlow` (public, default branch `main`). Act as the `farhanumer` account — confirm with `gh auth status`. The `origin` remote must keep the explicit username (`https://farhanumer@github.com/farhanumer/TaskFlow.git`); without it, a stale `~/.netrc` credential for an unrelated bot account silently hijacks push auth and pushes fail with a permission error.

## Workflow & human gates

This repo demos an end-to-end, **human-gated** feature workflow. For any piece of work:

1. Confirm with the user which Linear issue to work on — don't just pick one.
2. Implement the change in `TaskFlowPackage`, following existing view/model patterns.
3. Build and test via the `xcodebuildmcp-cli` skill before considering it done.
4. Show the result (simulator screenshot) and get the user's confirmation before opening a PR.
5. Open the PR via the `gh` skill (`gh pr create`) with a summary of the change and a screenshot. Never push directly to `main`, and never merge a PR without the user explicitly asking.
