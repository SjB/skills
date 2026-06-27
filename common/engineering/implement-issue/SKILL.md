---
name: implement-issue
description: Dispatch a child agent in an isolated git worktree to implement a `ready-for-agent` issue end-to-end.
disable-model-invocation: true
---

# Implement Issue

Dispatch a child agent in an isolated git worktree to implement a `ready-for-agent` issue end-to-end — explore, implement with TDD, run the full quality gate, push a branch, create a PR, comment on the issue, and update labels.

The issue tracker conventions live in [`docs/agents/issue-tracker.md`](../../../docs/agents/issue-tracker.md) and the triage label vocabulary in [`docs/agents/triage-labels.md`](../../../docs/agents/triage-labels.md). Both should have been provided to you already.

## Invocation

```
/skill:implement-issue <N> [--agent <name>] [--base <branch>] [--force]
```

- `<N>` — required, the issue number
- `--agent <name>` — **DEPRECATED**: this argument is ignored. The agent CLI is read from `docs/agents/agent-cli.md`, which is set up by `/setup-skills` Section E. Rerun `/setup-skills` to change the agent.
- `--base <branch>` — optional, target base branch (default: repo default branch).
- `--force` — optional, allow overwriting an existing worktree.

## Agent CLI Configuration

The CLI agent for child agents is configured in `docs/agents/agent-cli.md`. This file is written by `/setup-skills` Section E and contains:

```yaml
selected: <agent-name>
binary: <binary-name>
args: "<arguments including @{prompt}>"
```

Supported agents and their configurations are defined in `agents-seed.md` in the setup-skills skill directory.

## Process

### 1. Pre-flight checks

Stop on any failure and report clearly what needs fixing. Do not proceed.

#### 1b. Issue exists and is open

If the issue is not found or state is not `open`, report and stop.

#### 1c. Issue is labeled `ready-for-agent`

Check that the issue's labels include `ready-for-agent`. If not, report the current state and point the user to `/triage`. Stop.

#### 1d. No open blockers

Read the issue body for "Blocked by #M" references. For each referenced issue, check whether it is open:

If any blocker is open, report the blocking issues and stop.

#### 1e. Remote exists and base branch is reachable

Default base is the repo's default branch — infer from `git ls-remote --heads origin` (look for `main` or `master`). Allow an explicit `--base <branch>` override.

```bash
git ls-remote --heads origin <base>
```

If the remote is unreachable or the base branch doesn't exist, report and stop.

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

#### 1h. Running inside a tmux session

Confirm `$TMUX` is set. If not, report "This skill requires a tmux session. Start tmux and rerun." and stop.

#### 1i. Read agent CLI config

Read `docs/agents/agent-cli.md` and parse the `selected`, `binary`, and `args` fields. If the file is missing or malformed, report:

> Agent CLI not configured. Run `/setup-skills` Section E to configure the CLI agent for child agents.

Stop.

#### 1j. Validate binary on PATH

Confirm the configured `binary` is on PATH:

```bash
command -v <binary>
```

If the binary is not found, fail with:

> Agent '<binary>' not found on PATH — rerun /setup-skills to reconfigure.

Stop.

### 2. Setup

#### 2a. Label the issue `in-progress`

Apply the `in-progress` triage label.

#### 2b. Create the worktree

```bash
git worktree add -b <branch-name> ../<repo-name>-issue-<N> <base>
```

### 3. Compose and write the child prompt

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
  9. Change the issue label to `needs-review`: `tea issues edit <N> --add-labels "needs-review" --remove-labels "in-progress"`
  10. Print `DONE — issue #<N>`
- **Failure instruction**: "If any step fails, report where you stopped and what remains for manual recovery. Print the exact commands needed."

Write the full prompt to a temp file:

```bash
cat > /tmp/issue-<N>-prompt.md <<'PROMPT_EOF'
<full-composed-prompt>
PROMPT_EOF
```

### 4. Launch the child

#### 4a. Detect runtime environment

Check if `mise` is available:

```bash
command -v mise
```

If available, use `mise x --allow-env='*' --` as the runner prefix. Otherwise, fall back to `$SHELL -c`.

#### 4b. Compose the agent command

Substitute `@{prompt}` in the configured `args` with the absolute path to the temp prompt file:

- If `args` is non-empty: the agent command is `<binary> <substituted-args>`
- If `args` is empty (stdin-piping agents): the agent command is `cat <prompt-file> | <binary>`

#### 4c. Compose the full tmux command

```bash
tmux new-window -n "issue-<N>-<repo-slug>" -c <absolute-worktree-path> "<runner-prefix> <agent-command>"
```

**With mise:**
```bash
tmux new-window -n "issue-<N>-<repo>" -c /path/to/worktree "mise x --allow-env='*' -- <binary> <args-with-prompt-subbed>"
```

**Without mise (fallback):**
```bash
tmux new-window -n "issue-<N>-<repo>" -c /path/to/worktree "$SHELL -c '<binary> <args-with-prompt-subbed>'"
```

For stdin-piping agents (empty args), wrap the pipe command:

**With mise:**
```bash
tmux new-window -n "issue-<N>-<repo>" -c /path/to/worktree "mise x --allow-env='*' -- sh -c 'cat <prompt-file> | <binary>'"
```

**Without mise:**
```bash
tmux new-window -n "issue-<N>-<repo>" -c /path/to/worktree "$SHELL -c 'cat <prompt-file> | <binary>'"
```

The window stays open after the child completes so the user can review the output.

After tmux launches, clean up the temp file:

```bash
rm /tmp/issue-<N>-prompt.md
```

### 5. Print summary

After launching, print:
- Issue number and title
- Worktree path
- Branch name
- Base branch
- Agent used (from `docs/agents/agent-cli.md`)
- Tmux window name (so the user can find it)
- Cleanup command: `git worktree remove <worktree-path> && git worktree prune`

The parent's turn ends here. The user can dispatch another issue immediately.
