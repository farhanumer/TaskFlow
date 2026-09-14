# TaskFlow — Agent Guide

## Project
Native iOS app (Swift 6.1+, SwiftUI, iOS 17+). SPM package layout:
- `TaskFlow/` — app target (`@main` entry, `Assets.xcassets`)
- `TaskFlowPackage/Sources/TaskFlowFeature/` — all feature code (views, models)
- `TaskFlowPackage/Tests/TaskFlowFeatureTests/` — Swift Testing (`@Test`, `#expect`), not XCTest

MV pattern: no ViewModels, `@State`/`@Binding` in views, plain structs/enums for models.

## Tooling
- **Linear**: `linear-cli` skill. Project: "Claude Code Demo", team `FAR`.
- **Xcode**: `xcodebuildmcp-cli` skill. Workspace: `TaskFlow.xcworkspace`, scheme: `TaskFlow`, simulator: "iPhone 17". Run `xcodebuildmcp <workflow> <tool> --help` before first use of any subcommand.
- **GitHub**: `gh` skill. Repo: `farhanumer/TaskFlow`, default branch `main`, account `farhanumer`. Remote: `https://farhanumer@github.com/farhanumer/TaskFlow.git`.

### xcodebuildmcp-cli gotchas
- New model types need explicit `Sendable` conformance (Swift 6 strict concurrency)
- `simulator screenshot`: use `--return-format path`, not `--output-path` (flag doesn't exist)
- UI automation coordinates are simulator points, not screenshot pixels — scale by `pointSize / imagePixelSize`
- `snapshot-ui` frequently returns no usable elements (tab bar labels included); prefer `ui-automation tap --id <accessibilityIdentifier>` over coordinate taps — see Accessibility below
- Use `simulator test` / `simulator build` (workspace+scheme), not `swift-package test` / `swift-package build` — the package is iOS-only and SwiftPM's commands default to building for macOS, which fails on UIKit/SwiftUI iOS-only APIs

### Build / test / run commands
Always pass the same `--derived-data-path` to `build`, `test`, and `build-and-run` (e.g. `.build/DerivedData` at repo root) so later steps reuse the first build's artifacts instead of rebuilding from scratch:

```bash
xcodebuildmcp simulator build --workspace-path TaskFlow.xcworkspace --scheme TaskFlow --simulator-name "iPhone 17" --derived-data-path .build/DerivedData
xcodebuildmcp simulator test --workspace-path TaskFlow.xcworkspace --scheme TaskFlow --simulator-name "iPhone 17" --derived-data-path .build/DerivedData
xcodebuildmcp simulator build-and-run --workspace-path TaskFlow.xcworkspace --scheme TaskFlow --simulator-name "iPhone 17" --derived-data-path .build/DerivedData
```
Build once, then test, then run — in that order — so the unit-test build and the run build are incremental against the first build rather than each starting cold.

### Accessibility
When adding interactive elements (buttons, toggles, list rows, etc.) in `TaskFlowFeature` views, set an `.accessibilityIdentifier("...")` on them. This lets `xcodebuildmcp-cli` locate elements with `ui-automation tap --id <identifier>` for functional/UI testing instead of guessing screenshot coordinates, which is slow and brittle. Use stable, descriptive identifiers (e.g. `"task-row-favorite-\(task.id)"`, `"tasks-favorites-filter-toggle"`).

## Workflow
1. Confirm which Linear issue with the user; pull details via `linear issue view <ID>`
2. Plan mode: propose a plan and wait for explicit approval before writing any code
3. Mark the issue **In Progress** via `linear-cli`; create feature branch `feature/<issue-key>-<short-slug>` off `main`
4. Implement in `TaskFlowPackage`, following existing view/model patterns
5. Build, test, then run via `xcodebuildmcp-cli`, in that order, sharing one `--derived-data-path` (see Build / test / run commands above)
6. Show simulator screenshot; wait for user confirmation
7. Push branch and open PR via `gh pr create` against `main`; attach confirmed simulator screenshots with `--attach <file>#<alt text>` (uploads to `github.com/user-attachments/assets/...` so they render inline — don't use gists or relative paths, which don't render); if the PR already exists, add them via `gh pr comment <number> --attach <file>#<alt text>`. Mark the issue **Done** via `linear-cli`; never push to `main` directly; never merge without user asking
