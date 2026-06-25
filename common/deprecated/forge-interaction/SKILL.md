---
name: forge-interaction
description: Use when the user wants forge work such as opening a PR, creating or listing issues, checking CI, looking at the repo, pushing a branch, publishing changes, or making a release on GitHub or Gitea. This skill now delegates to specialized skills for better predictability.
---

# Forge Interaction (Router)

This skill has been refactored into specialized skills for better predictability and maintainability:

- **GitHub**: Use `/forge-github` for GitHub repositories, issues, pull requests, releases, or CI
- **Gitea**: Use `/forge-gitea` for Gitea repositories, issues, pull requests, releases, or CI

## Purpose

This router skill delegates to the appropriate specialized forge interaction skill based on the target forge. Each specialized skill handles one forge type completely, making them more predictable and easier to maintain.

## When to use:

- If you're unsure which forge you're working with, use this skill and it will guide you
- For general forge work without specifying the forge type
- When you want the system to figure out which specialized skill to use

## Delegation Logic

The router analyzes your request and determines whether to delegate to:

1. **GitHub skill** (`/forge-github`) - for GitHub repositories and workflows
2. **Gitea skill** (`/forge-gitea`) - for Gitea repositories and workflows

Each specialized skill contains the complete decision tree and implementation for its respective forge type.

## Recommendation

For most predictable results, use the specialized skills directly:
- `/forge-github` when working with GitHub
- `/forge-gitea` when working with Gitea

This separation follows the principle of single responsibility and makes each skill more focused and reliable.

## Strict Decision Tree

Follow this order every time.

### 1. Determine the target remote

1. If the user explicitly says which remote or forge to use, use that.
2. Else, if user/project memory or repo guidance states where to find the forge, use that.
3. Else, if a remote named `forge` exists, use `forge`.
4. Else, if the user has configured a default remote, use that.
5. Else, use `origin`.

Useful inspection commands:

```bash
git remote -v
git config --get checkout.defaultRemote
git config --get clone.defaultRemoteName
git config --get branch.$(git branch --show-current).remote
```

Interpretation:

- A remote named `forge` is the preferred convention for the canonical forge remote.
- If no `forge` remote exists, `origin` is the fallback.
- If the current branch has an upstream remote and no stronger rule applies, treat that as the user's configured default for the current work.

Only mention this selection if there is ambiguity or a conflict.

### 2. Determine the forge type from the chosen remote

Inspect the selected remote URL:

```bash
git remote get-url <remote>
```

Classify it:

- URLs containing `github.com` are GitHub.
- URLs containing `gitea`, or a known Gitea host from memory/project guidance, are Gitea.
- If the remote is self-hosted and ambiguous, inspect repo guidance, memory, and web/API/tool configuration before asking.

Do not choose based on which CLI is installed. The remote determines the forge; the forge determines the CLI.

### 3. Choose the CLI

- If the forge is GitHub, use `gh`.
- If the forge is Gitea, use `tea`.

Check whether the chosen CLI is available:

```bash
command -v gh >/dev/null 2>&1 && gh --version
command -v tea >/dev/null 2>&1 && tea --version
```

If the needed CLI is missing:

- Tell the user which CLI is required: `gh` for GitHub, `tea` for Gitea.
- Tell the user to install it.
- If it may already be installed but not discoverable, tell the user to add it to their `PATH`.
- Do not use the wrong CLI as a fallback.

### 4. Check authentication/context

Use read-only checks for the selected tool:

```bash
# GitHub
gh auth status
gh repo view

# Gitea
tea login list
tea repos ls
```

If authentication is missing, tell the user which CLI needs login/configuration. Do not ask the user to paste tokens or secrets.

### 5. Do the requested forge task

Perform the requested action with the selected CLI.

For GitHub, use `gh` commands such as:

```bash
gh issue list
gh issue create
gh issue comment
gh pr list
gh pr create
gh pr view
gh pr comment
gh pr edit
gh pr merge
gh run list
gh run view
gh release list
gh release create
```

For Gitea, use `tea` commands such as:

```bash
tea issues list
tea issues create
tea issues comment
tea pulls list
tea pulls create
tea pulls view
tea pulls comment
tea pulls merge
tea releases list
tea releases create
```

Use exact command syntax supported by the installed CLI version; inspect help when needed:

```bash
gh help
tea help
```

## Mutating Actions

Mutating forge actions are allowed when clearly requested by the user, including:

- create an issue;
- modify an issue;
- comment on an issue;
- create a pull request;
- modify a pull request;
- comment on a pull request;
- push a branch;
- publish changes;
- create a release.

Still be careful with destructive or high-impact actions:

- Ask before deleting branches, tags, releases, issues, or repositories.
- Ask before force-pushing.
- Ask before merging a PR unless the user explicitly asked to merge it.
- Ask before overwriting existing release assets or tags.

## Branch and PR Preparation

Before creating or updating a PR:

1. Select the remote using the strict decision tree.
2. Select the CLI from the remote's forge type.
3. Inspect branch state and upstream tracking.
4. Inspect the diff against the target branch.
5. Read the PR template if one exists.
6. Push the branch if needed and requested by the workflow.
7. Create or update the PR.

Useful local inspection:

```bash
git status --short --branch
git branch -vv
git diff --stat
git diff --check
```

## Output Style

Normally, do not over-explain. If the remote/tool selection is straightforward, just complete the task and summarize the result.

Report detection details only when there is ambiguity, conflict, missing tooling, or failure. In those cases include:

- selected remote;
- detected forge;
- selected CLI;
- reason for the choice;
- what the user needs to fix, if anything.

## Companion Personal Skill

Personal forge preferences should live in a separate skill or memory entry, not in this general skill. That companion skill/memory may specify things like:

- preferred default remote conventions;
- known personal Gitea or GitHub hosts;
- preferred issue/PR/release styles;
- project-specific forge rules.

This general skill should consume that memory/guidance when present, but keep the generic decision tree above as the fallback.
