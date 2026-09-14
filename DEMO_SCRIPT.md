# TaskFlow Demo Script — 5 minutes

## Overview
End-to-end, human-gated iOS feature workflow using Claude Code with three integrated tools:
Linear (issue tracking), XcodeBuildMCP (build/test/simulator), and GitHub (PRs).

---

## [0:00–0:20] Intro
> "Hi, my name is Farhan. Today I want to show you one slice of how I use Claude Code in my day-to-day — specifically how I run a human-gated feature development workflow for an iOS app I'm building."

---

## [0:20–0:40] Set the scene — show the app
> "This is TaskFlow — a personal project I've been building: a task manager with three tabs — Tasks, Categories, and Profile. Simple, but a real working SwiftUI app, which makes it a fair stand-in for actual day-to-day feature work."

*Show the simulator briefly — swipe between tabs.*

---

## [0:40–0:55] Kick off plan mode — early, on purpose
> "The first thing I'm going to do is start the planning phase now, before I explain anything, so we're not waiting on it later."

*Open terminal. Pull the Linear issue:*
```
linear issue view FAR-X
```

> "Here's the issue I'm going to implement today — [read title]. I'm going to give this to Claude Code in plan mode, which means it will read the issue, propose a plan, and wait for my approval before writing a single line of code."

*Type the prompt and hit enter:*
```
Implement FAR-X. Use plan mode — propose a plan based on the issue acceptance criteria and wait for my approval before writing any code.
```

> "And that's running now. While it's thinking, let me walk you through how this is all set up."

---

## [0:55–1:20] CLAUDE.md — the agent guide
> "Every Claude Code project can have a CLAUDE.md — a guide that loads into the agent's context at the start of every session. Think of it as the onboarding doc you wish every new team member actually read."

*Open CLAUDE.md in the editor.*

> "Ours is intentionally lean — about 40 lines. It tells the agent three things: the project structure and patterns to follow, which tools to use and how, and the exact workflow with human gates built in. No ambiguity, no rediscovering things that already burned us."

---

## [1:20–1:50] Skills and MCPs — the three tools
> "The tooling section routes everything through skills. A skill in Claude Code is a packaged set of instructions — you invoke it by name and it tells the agent exactly how to talk to a specific CLI or service. You can also use MCPs — Model Context Protocol — where tools register directly as callable functions in the agent's context. Both are ways to give the agent reliable, repeatable access to external systems."

> "We're using three:"
> - **Linear** via the `linear-cli` skill — for issue tracking and acceptance criteria
> - **XcodeBuildMCP** via the `xcodebuildmcp-cli` skill — drives Xcode builds, tests, and the simulator without hand-writing xcodebuild commands
> - **GitHub** via the `gh` skill — PR creation and repo management

---

## [1:50–2:10] The human-gated workflow
> "The workflow section is the heart of it. Seven steps, and three of them are explicit human gates."

*Point to the workflow section in CLAUDE.md.*

> "Step 1: I confirm which issue we're working on — the agent doesn't just pick one.
> Step 2: Plan mode — it proposes, I approve. No code until I say go.
> Step 6: It shows me a simulator screenshot and waits before opening a PR.
> Step 7: It opens the PR but never merges without me asking.
> The agent does the work; I stay in control of every decision point."

---

## [2:10–2:30] Review and approve the plan
> "Let's see what it came up with."

*Switch back to the terminal — the plan should already be there.*

*Read through the plan briefly on screen.*

> "This looks right — it's grounded in the acceptance criteria from the Linear issue. I'm going to approve it."

*Type approval and hit enter.*

---

## [2:30–3:45] Watch implementation run
> "Now it's implementing. It's created a feature branch, it's writing the code in the right package following the existing patterns, and it's about to build and run tests — all via the XcodeBuildMCP skill."

*Narrate as it goes — branch creation, code changes, build output, test results.*

---

## [3:45–4:00] Screenshot confirmation gate
> "Build passed, tests passed. Now it's taking a simulator screenshot and waiting — this is gate number two. It won't open a PR until I confirm what I'm looking at."

*Screenshot appears. Review it.*

> "Looks good. Confirmed."

---

## [4:00–4:30] PR opens — show it on GitHub
> "And there's the PR — against main, with a summary of what changed and the screenshot attached. The branch is pushed, the PR is open, and nothing has been merged."

*Open the PR in the browser briefly.*

---

## [4:30–5:00] Wrap up
> "That's the full loop — Linear issue to merged-ready PR, with three human gates, three integrated tools, and the agent guided by a 40-line CLAUDE.md. The planning ran in the background while I was explaining, the implementation ran while I narrated, and I stayed in control of every decision that actually mattered. That's how I use Claude Code."

---

## Timing reference

| Time | Action | Claude Code |
|------|--------|-------------|
| 0:00–0:20 | Intro | — |
| 0:20–0:40 | Show TaskFlow in simulator | — |
| 0:40–0:55 | Pull issue, type prompt, hit enter | **starts planning** |
| 0:55–1:20 | Walk through CLAUDE.md | generating plan |
| 1:20–1:50 | Explain skills, MCPs, three tools | generating plan |
| 1:50–2:10 | Walk through human-gated workflow | generating plan (likely done) |
| 2:10–2:30 | Review plan, approve | waiting for approval |
| 2:30–3:45 | Narrate implementation | writing code, building, testing |
| 3:45–4:00 | Screenshot gate, confirm | waiting |
| 4:00–4:30 | PR opens, show on GitHub | PR created |
| 4:30–5:00 | Wrap up | — |
