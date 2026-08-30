---
name: forge-cli
description: Provides copy-paste, non-interactive tea, gh, and glab commands for issue and pull or merge request work. Use whenever a task needs tracker inspection, assignment, labels, comments, reviews, CI, or merge operations.
---

# Forge CLI

Use this shared skill instead of reproducing forge CLI syntax in another skill.

Run the bundled read-only preflight with the target repository as the working directory:

```bash
bash <resolved-skill-dir>/scripts/detect-forge.sh
```

Resolve `<resolved-skill-dir>` from this `SKILL.md`, not from the target repository.

It prints one selected CLI: `forge=tea`, `forge=gh`, or `forge=glab`. Read **only** the matching recipe:

- `forge=tea` → `references/tea.md`
- `forge=gh` → `references/gh.md`
- `forge=glab` → `references/glab.md`

Do not load or compare the other recipes. This keeps one forge's syntax in context.

Commands assume the current checkout identifies the repository. Replace `ID` (issue), `PR` (pull/merge request), `USER`, `OLD`, `NEW`, `BASE`, `HEAD`, `TITLE`, and `BODY_FILE`. Keep bodies in a file to avoid quoting and interactive prompts.

## Shared safety rules

1. Use JSON output for reads; inspect the returned object before deciding eligibility, dependencies, or merge readiness.
2. Use one mutation per state transition, then re-read and confirm the state/label/comment changed.
3. If a recipe returns an unknown command or flag, run that CLI command's `--help`; do not switch forge CLIs or guess.
4. Check command exit status. Authentication, repository resolution, missing permissions, unsupported relationships, and unavailable CI are blockers.
5. Do not use auto-merge, admin/bypass, or force options. Merge only after every workflow gate passes.

Honor `DEV_WORKFLOW_FORGE=tea`, `gh`, or `glab` when explicitly configured; otherwise use GitHub → `gh`, GitLab → `glab`, and other Tea-compatible hosts → `tea`.

Keep these identifiers distinct: tracker issue/ticket ID, PR/MR ID, durable URL, and local branch name. Never use a branch name as ticket identity.
