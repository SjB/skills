---
name: forge-preferences
description: Use with forge-interaction to apply Steve's personal or project-specific GitHub/Gitea remote, CLI, issue, PR, and release preferences.
---

# Forge Preferences

Use this companion skill with `/forge-interaction` when personal or project-specific forge preferences are relevant.

## Purpose

Store personal conventions that should not live in the generic forge interaction skill.

## Current Preferences

- If a remote named `forge` exists, treat it as the canonical forge remote.
- If no `forge` remote exists, use the user's configured default remote when available.
- If no default remote is configured, use `origin`.
- Use the forge type of the selected remote to choose the CLI:
  - GitHub → `gh`
  - Gitea → `tea`
- If the correct CLI is missing, tell the user to install it or add it to `PATH`.
- Do not use the wrong CLI as a fallback.

## Derived Preferences (auto-detected at runtime)

- Canonical forge remote: prefer `forge`, then default remote, then `origin`.
- Forge CLI: determined from remote URL (GitHub → `gh`, Gitea → `tea`).
- Known personal Gitea hosts and GitHub usernames/orgs are collected from the remote URL and git CLI at time of use — no hardcoded list.

## Issue Labels

See `triage-labels.md` in this directory for the canonical-to-actual label mapping.

## PR Conventions

- PR titles follow Conventional Commits: `type(scope): description`.
  - Common types: `feat`, `fix`, `refactor`, `docs`, `chore`, `test`, `style`.
- PR body is freeform but should summarise the change and any breaking or noteworthy details.

## Release Conventions

- Tags follow semver: `v{major}.{minor}.{patch}` (e.g. `v1.2.3`).
- Releases are created from the tag with auto-generated or manually curated notes.
