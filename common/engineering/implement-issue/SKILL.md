---
name: implement-issue
disable-model-invocation: true
---

# Implement Issue

Dispatch a child agent in an isolated git worktree to implement a `ready-for-agent` issue end-to-end — explore, implement with TDD, run the full quality gate, push a branch, create a PR, comment on the issue, and update labels.

The issue tracker conventions live in [`docs/agents/issue-tracker.md`](../../../docs/agents/issue-tracker.md) and the triage label vocabulary in [`docs/agents/triage-labels.md`](../../../docs/agents/triage-labels.md). Both should have been provided to you already.

## Process

### 1. Pre-flight checks

Stop on any failure and report clearly what needs fixing. Do not proceed.

#### 1a. `tea` CLI

Confirm `tea` is on PATH. If missing, tell the user to install it and stop.

#### 1b. Issue exists and is open

```bash
tea issue <N> -o json
```

If the issue is not found (404) or state is not `open`, report and stop.

#### 1c. Issue is labeled `ready-for-agent`

Check that the issue's labels include `ready-for-agent`. If not, report the current state and point the user to `/triage`. Stop.

#### 1d. No open blockers

Read the issue body for "Blocked by #M" references. For each referenced issue, check whether it is open:

```bash
tea issue <M> -o json
```

If any blocker is open, report the blocking issues and stop.

#### 1e. Remote exists and base branch is reachable

Default base is the repo's default branch — infer from `git ls-remote --heads origin` (look for `main` or `master`). Allow an explicit `--base <branch>` override.

```bash
git ls-remote --heads origin <base>
```

If the remote is unreachable or the base branch doesn't exist, report and stop. SSH auth issues (e.g. `Permission denied (publickey)`) are a failure — tell the user which key is needed.

> **SSH note:** `tea` uses HTTPS and may work when git-over-SSH does not. If the first `git ls-remote` fails with an SSH error, try `export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)` and retry before failing.

#### 1f. Branch name is free

Derive the branch name from the issue title:

- Format: `issue-<N>-<slug>`
- Slug: lowercase the title, strip to `[a-z0-9-]`, truncate to ~4–5 short words (max ~50 chars), collapse double hyphens
- If the title yields no usable slug, fall back to `issue-<N>`

Check that the branch doesn't already exist on the remote:

```bash
git ls-remote --heads origin <branch-name>
```

If it exists, report and stop. (No auto-suffix, no force-push.)

#### 1g. Worktree path is free

The worktree path is a sibling to the main repo: `../<repo-name>-issue-<N>`. Check that it doesn't already exist:

```bash
ls -d ../<repo-name>-issue-<N>
```

If it exists, report and stop. Let the user override with `--force`.

### 2. Setup

#### 2a. Fetch latest base

```bash
git fetch origin <base>
```

#### 2b. Label the issue `in-progress`

```bash
tea issues edit <N> --add-labels "in-progress" --remove-labels "ready-for-agent"
```

#### 2c. Create the worktree

```bash
git worktree add -b <branch-name> ../<repo-name>-issue-<N> <base>
```

### 3. Compose the child prompt

Assemble a single prompt that the child agent will receive. Include:

- **Issue body** — the full markdown body from `tea issue <N> -o json`
- **Comments** — all comments, if any
- **Standing instruction**: "Implement using TDD: write a failing test first, make it pass, refactor. Explore the codebase before writing code. Respect ADRs and the project domain glossary. Set up the project (install dependencies, build) before starting. The issue body may contain Implementation Decisions and Testing Decisions sections — treat these as constraints."
- **Context**: "Base branch: `<base>`. Target your PR at `<base>`. Branch name: `<branch-name>`."
- **Checklist** — a numbered checklist the child should work through:
  1. Explore the codebase and read the issue body + comments thoroughly
  2. Install dependencies and build the project
  3. Implement the change using TDD (red-green-refactor)
  4. Run the full project quality gate (infer from package.json, Makefile, Cargo.toml, etc.), fix until green
  5. Commit with conventional commits (`feat:` for enhancement, `fix:` for bug) referencing `(#<N>)`
  6. Push the branch: `git push origin <branch-name>`
  7. Create a PR with: link to the issue, one-sentence summary, short key-changes list
  8. Comment on the issue with the PR link: `tea comment <N> "PR opened: <url>"`
  9. Change the issue label to `in-review`: `tea issues edit <N> --add-labels "in-review" --remove-labels "in-progress"`
  10. Print `DONE — issue #<N>`
- **Failure instruction**: "If any step fails, report where you stopped and what remains for manual recovery. Print the exact commands needed."

### 4. Launch the child

Open a new tmux window in the worktree directory and run `pi` with the composed prompt:

```bash
tmux new-window -c <absolute-worktree-path> "pi --prompt '<escaped-prompt>'"
```

The pane stays open after the child completes so the user can review the output.

### 5. Print summary

After launching, print:
- Issue number and title
- Worktree path
- Branch name
- Base branch
- Tmux window (so the user can find it)
- Cleanup command: `git worktree remove <worktree-path> && git worktree prune`

The parent's turn ends here. The user can dispatch another issue immediately.
