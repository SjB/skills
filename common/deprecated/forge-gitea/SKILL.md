---
name: forge-gitea
---

# Gitea Forge Interaction

Use this skill for Gitea forge work when the user wants to interact with Gitea repositories, issues, pull requests, releases, or CI.

## Purpose

Choose the correct Gitea CLI (`tea`) and use it to interact with Gitea issues, pull requests, releases, CI, and repository state.

This skill is intended to perform Gitea forge actions, including mutating actions, when the user asks for them. Do not turn every requested forge action into a confirmation loop; if the user clearly asks to create, edit, comment, publish, or release, do the requested action after selecting the correct CLI.

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

### 2. Choose the CLI

Use `tea` for Gitea interactions.

Check whether the chosen CLI is available:

```bash
command -v tea >/dev/null 2>&1 && tea --version
```

If the needed CLI is missing:

- Tell the user which CLI is required: `tea` for Gitea.
- Tell the user to install it.
- If it may already be installed but not discoverable, tell the user to add it to their `PATH`.
- Do not use the wrong CLI as a fallback.

### 3. Check authentication/context

Use read-only checks for the selected tool:

```bash
tea login list
tea repos ls
```

If authentication is missing, tell the user which CLI needs login/configuration. Do not ask the user to paste tokens or secrets.

### 4. Do the requested forge task

Perform the requested action with `tea` commands such as:

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
2. Inspect branch state and upstream tracking.
3. Inspect the diff against the target branch.
4. Read the PR template if one exists.
5. Push the branch if needed and requested by the workflow.
6. Create or update the PR.

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