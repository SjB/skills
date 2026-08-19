---
name: implement-isolation-tmux
description: "Dispatch a child agent in an isolated git worktree to implement a piece of work based on a PRD or set of issues."
disable-model-invocation: true
---

## Invocation

/skill:implement-isolation-tmux <N> [--base <branch>] [--force]

- `<N>` — required, the issue number
- `--base <branch>` — optional, target base branch (default: repo default branch)
- `--force` — optional, remove the existing worktree directory first, then recreate

Triage labels follow the vocabulary in `docs/agents/triage-labels.md`.

## Process

## 1. Claim and isolate

Change the issue triage label to `in-progress`, remove all other labels. Derive `<issue-slug>` from the issue title: lowercase, replace spaces with hyphens, strip non-alphanumeric characters (keep hyphens). Then create a git worktree for the ticket as a sibling directory named `../issue-<N>-<issue-slug>`, checked out from the base branch. Switch to the worktree. The branch name matches the directory: `issue-<N>-<issue-slug>`.

```bash
git worktree add -b issue-<N>-<issue-slug> ../issue-<N>-<issue-slug> <base>
```

Stay in the worktree directory for the rest of the process.

Completion criterion: The issue label is confirmed as `in-progress` and the worktree exists at `../issue-<N>-<issue-slug>` with branch `issue-<N>-<issue-slug>` checked out.

### 2. Compose the child prompt

Assemble a single prompt that the child agent will receive. Include:

- **Issue body** — the full markdown body of the issue.
- **Comments** — all comments, if any
- **Standing instruction**: "Implement the work described by the user in the spec or tickets, using tdd skill where possible. Run typechecking regularly, run single test files regularly, and run the full test suite once at the end. Once done, use code-review skill to review the work. Commit your work and push the new branch and create a PR with a link to the issue, one-sentence summary, and short key-changes list. Comment on the issue with the PR link: `PR opened: <url>`. Change the issue triage label to needs-review when done. Remove all other labels"

- **Failure instruction**: "If any step fails, report where you stopped and what remains for manual recovery. Print the exact commands needed."

Completion criterion: The prompt is composed with all required sections (issue body, comments, standing instruction, failure instruction).

### 3. Launch the child via tmux-launch-agent

Use the `tmux-launch-agent` skill to fork the child agent into a new tmux window. Tmux-launch-agent handles agent detection, config lookup, command building (prompt-file or stdin-pipe), mise/SHELL wrapping, and `tmux new-window` creation.

Pass these parameters:

| Parameter | Value |
|-----------|-------|
| `--name` | `"issue-<N>-<issue-slug>"` — tmux window title |
| Remaining args | The full prompt text composed in step 2 |

Ensure the child agent starts in the worktree. If the current pane's working directory is already inside `<absolute-worktree-path>` (from step 1), tmux-launch-agent's new window inherits it. Otherwise, pass `-c <absolute-worktree-path>` when invoking tmux-launch-agent so the child agent starts in the worktree directory.

Let tmux-launch-agent handle prompt-file creation — it writes a temp file automatically when the target agent uses prompt-file mode. Pass the prompt text inline.

The window stays open after the child completes so the user can review the output.

Completion criterion: `tmux-launch-agent` exits 0 and a new tmux window appears with the child agent session active.

### 4. Print summary

After launching, print:

- Issue number and title
- Worktree path
- Branch name
- Base branch
- Agent used (detected by tmux-launch-agent)
- Tmux window name (so the user can find it)
- Cleanup command: `git worktree remove <worktree-path> && git worktree prune`
