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
- Tab bar labels aren't exposed in `snapshot-ui`; use coordinate taps

## Workflow
1. Confirm which Linear issue with the user; pull details via `linear issue view <ID>`
2. Plan mode: propose a plan and wait for explicit approval before writing any code
3. Mark the issue **In Progress** via `linear-cli`; create feature branch `feature/<issue-key>-<short-slug>` off `main`
4. Implement in `TaskFlowPackage`, following existing view/model patterns
5. Build and test via `xcodebuildmcp-cli`
6. Show simulator screenshot; wait for user confirmation
7. Push branch and open PR via `gh pr create` against `main`; mark the issue **Done** via `linear-cli`; never push to `main` directly; never merge without user asking
