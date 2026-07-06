---
name: implement-issue
description: "Dispatch a child agent in an isolated git worktree to implement a piece of work based on a PRD or set of issues."
disable-model-invocation: true
---

## Invocation

/skill:implement-issue <N> [--base <branch>] [--force]

- `<N>` — required, the issue number
- `--base <branch>` — optional, target base branch (default: repo default branch)
- `--force` — optional, allow overwriting an existing worktree

## Process

### 1. Setup

#### a. Label the issue `in-progress`

Change the issue triage label to `in-progress`.

Completion criterion: The issue label is confirmed as `in-progress`.

#### b. Create the worktree

```bash
git worktree add -b <branch-name> ../<repo-name>-issue-<N> <base>
```

Completion criterion: The worktree exists at `../<repo-name>-issue-<N>` and the new branch is checked out.

### 2. Compose the child prompt

Assemble a single prompt that the child agent will receive. Include:

- **Issue body** — the full markdown body of the issue.
- **Comments** — all comments, if any
- **Standing instruction**: "Implement using /tdd where possible, at the pre-agreed seam. Run typechecking regularly, run single test files regularly, and run the full test suite once at the end. Once done, use /code-review to review the work. Commit your work and push the new branch and create a PR with a link to the issue, one-sentence summary, and short key-changes list. Comment on the issue with the PR link: `PR opened: <url>`. Change the issue triage label to needs-review when done."
- **Failure instruction**: "If any step fails, report where you stopped and what remains for manual recovery. Print the exact commands needed."

(The prompt is passed as arguments to tmux-launch-agent in step 3, which handles writing it to a temp file if needed.)

Completion criterion: The prompt is composed with all required sections (issue body, comments, standing instruction, failure instruction).

### 3. Launch the child via tmux-launch-agent

Use the [`tmux-launch-agent`](../../../../.agents/skills/tmux-launch-agent/SKILL.md) skill to fork the child agent into a new tmux window. Tmux-launch-agent handles agent detection, config lookup, command building (prompt-file or stdin-pipe), mise/SHELL wrapping, and `tmux new-window` creation.

Pass these parameters:

| Parameter | Value |
|-----------|-------|
| `--name` | `"issue-<N>-<repo-slug>"` — tmux window title |
| Remaining args | The full prompt text composed in step 2 |

Ensure the child agent starts in the worktree. If the current pane's working directory is already inside `<absolute-worktree-path>` (from step 1b), tmux-launch-agent's new window inherits it. Otherwise, add `-c <absolute-worktree-path>` to the `tmux new-window` command in tmux-launch-agent's step 6.

Do **not** pre-write the prompt to a separate file — tmux-launch-agent writes its own temp file if the target agent uses prompt-file mode.

The window stays open after the child completes so the user can review the output.

Completion criterion: `tmux new-window` exits 0 and a new tmux window appears with the child agent session active.

### 4. Print summary

After launching, print:
- Issue number and title
- Worktree path
- Branch name
- Base branch
- Agent used (detected by tmux-launch-agent)
- Tmux window name (so the user can find it)
- Cleanup command: `git worktree remove <worktree-path> && git worktree prune`

The parent's turn ends here. The user can dispatch another issue immediately.
