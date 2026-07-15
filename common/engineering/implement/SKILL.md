---
name: implement-isolation
description: "Implement a piece of work based on a spec or set of tickets in isolation."
disable-model-invocation: true
---

## Invocation

/skill:implement <N> [--base <branch>] [--force]

- `<N>` — required, the ticket/issue number
- `--base <branch>` — optional, target base branch (default: repo default branch)
- `--force` — optional, allow overwriting an existing `worktree`

Triage labels follow the vocabulary in `docs/agents/triage-labels.md`.

## Process

### 1. Claim the ticket

Label the issue `in-progress`, remove all other labels.

### 2. Isolate the workspace

```bash
git worktree add -b <branch-name> ../issue-<N>-<repo-slug> <base>
```

Change into the new worktree directory.

### 3. Implement

Drive every acceptance criterion through **red-green-refactor**: write the test first (red), make it pass (green), clean up (refactor). No code without a failing test first.

### 4. Verify

Run the full test suite. Every test must pass.

### 5. Review

Run /code-review against the base branch. Fix every finding before proceeding.

### 6. Ship

Push the branch, open a PR. The PR description must include a link to the ticket and a key-changes list.

Comment on the issue: `PR opened: <url>`. Label the issue `needs-review`, remove all other labels.
