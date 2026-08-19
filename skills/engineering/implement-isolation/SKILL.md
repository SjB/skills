---
name: implement-isolation
description: "Implement a piece of work based on a spec or set of tickets in isolation."
disable-model-invocation: true
---

## Invocation

/skill:implement-isolation <N> [--base <branch>] [--force]

- `<N>` — required, the ticket/issue number
- `--base <branch>` — optional, target base branch (default: repo default branch)
- `--force` — optional, remove the existing worktree directory first, then recreate

Triage labels follow the vocabulary in `docs/agents/triage-labels.md`.

## Process

### 1. Claim and isolate

Change the issue triage label to `in-progress`, remove all other labels. Derive `<issue-slug>` from the issue title: lowercase, replace spaces with hyphens, strip non-alphanumeric characters (keep hyphens). Then create a git worktree for the ticket as a sibling directory named `../issue-<N>-<issue-slug>`, checked out from the base branch. Switch to the worktree. The branch name matches the directory: `issue-<N>-<issue-slug>`.

```bash
git worktree add -b issue-<N>-<issue-slug> ../issue-<N>-<issue-slug> <base>
```

Stay in the worktree directory for the rest of the process.

Completion criterion: The issue label is confirmed as `in-progress` and the worktree exists at `../issue-<N>-<issue-slug>` with branch `issue-<N>-<issue-slug>` checked out.

### 2. Implement

Start a subagent to implement the work in isolation. The subagent receives a single prompt that includes:

- Issue body: the full markdown body of the issue.
- Comments: all comments, if any
- Implement: the work described by the user in the spec or tickets, using tdd skill where possible. Run typechecking regularly, run single test files regularly, and run the full test suite once at the end.

Completion criterion: The subagent exits with code 0 and all changes are committed.

### 3. Review

Start a reviewer subagent that runs the `code-review` skill against the base branch to identify findings in the diff. Wait for the reviewer to finish.

Review each finding and fix the code until zero findings remain. Commit fixes as you go.

Completion criterion: All code-review findings are resolved (zero open findings) and fixes are committed.

### 4. Ship

Push the branch, open a PR. The PR description must include a link to the ticket and a key-changes list.

Comment on the issue: `PR opened: <url>`. Label the issue `needs-review`, remove all other labels.

Print a cleanup command for the user: `git worktree remove ../issue-<N>-<issue-slug> && git worktree prune`

### Failure recovery

If the implement subagent exits non-zero or the review finds issues that cannot be fully resolved, stop. Report to the user: issue number, what was completed, what failed, and the exact commands needed to resume or clean up (including `git worktree remove ...`). Do not push partial work.
