---
name: setup-skills
description: Configure this repo for the engineering skills, set up its issue tracker, triage label vocabulary, and domain doc layout. Run once before first use of the other engineering skills.
disable-model-invocation: true
---

# Setup Engineering Skills

Scaffold the per-repo configuration that the engineering skills assume:

- Issue tracker: where issues live (never assume a default forge)
- Triage labels: the strings used for the canonical triage roles, labels are defined in `triage-labels.md`
- Domain docs: where `CONTEXT.md` and ADRs live, and the consumer rules for reading them
- **ADR wiki** — where ADRs are stored (forge wiki, cloned into `docs/adr/`), and the clone/push workflow

This is a prompt-driven skill, not a deterministic script. Explore, present what you found, confirm with the user, then write.

## Process

### 1. Explore

Look at the current repo to understand its starting state. Read whatever exists; don't assume:

- `git remote -v` and `.git/config` — is this a GitHub repo? Which one?
- `AGENTS.md` and `CLAUDE.md` at the repo root — does either exist? Is there already an `## Agent skills` section in either?
- `CONTEXT.md` and `CONTEXT-MAP.md` at the repo root
- `docs/adr/` and any `src/*/docs/adr/` directories
- `docs/agents/` — does this skill's prior output already exist?
- Is the `triage` skill installed? (a `triage` skill folder alongside this one, or `triage` in your available skills.) This decides whether Section B runs at all.
- Monorepo signals — a `pnpm-workspace.yaml`, a `workspaces` field in `package.json`, or a populated `packages/*` with its own `src/`. Present only in a genuinely large multi-package repo; their absence means single-context, which is almost every repo.

### 2. Present findings and ask

Summarise what's present and what's missing. Then take the sections in order — one section, one answer, then the next.

Lead each section with the recommended answer so the user can accept it in a word. Give a one-line explainer only when the choice genuinely branches; skip the section entirely when exploration already settled it (Section B when `triage` isn't installed, Section C when there's no monorepo).

Section A - Issue tracker:

> Explainer: The "issue tracker" is where issues live for this repo. Skills like `to-tickets`, `triage`, `to-spec`, and `qa` read from and write to it — they need to know whether to call `gh issue create`, or follow some other workflow you describe. Pick the place you actually track work for this repo.

Default posture: these skills were designed for GitHub. If a `git remote` points at GitHub, propose that. If a `git remote` points at GitLab (`gitlab.com` or a self-hosted host), propose GitLab. If a `git remote` point at a Gitea (a self-hosted host with a `gitea` in the url). Otherwise ask the user, offer:

- **GitHub** — issues live in the repo's GitHub Issues (uses the `gh` CLI)
- **GitLab** — issues live in the repo's GitLab Issues (uses the [`glab`](https://gitlab.com/gitlab-org/cli) CLI)
- Gitea — issues live in the repo's Gitea Issues (uses the `tea` CLI)
- **Other** (Jira, Linear, etc.) — ask the user to describe the workflow in one paragraph; the skill will record it as freeform prose

Record the choice in `docs/agents/issue-tracker.md`. The GitHub and GitLab templates carry a "PRs as a request surface" flag, defaulted **off** — leave it off and don't raise it; a user who wants external PRs in the triage queue can flip the flag in the file later.

**Section B — Triage label vocabulary.** Skip this section entirely if the `triage` skill isn't installed (exploration told you) — an uninstalled skill needs no labels.

If it is installed, ask exactly one question:

> Do you want to keep the default triage labels? (recommended: **yes**)

The defaults canonical roles are listed in `triage-labels.md` each label string equal to its name. On **yes**, write them as-is. Only if the user says no — usually because their tracker already uses other names (e.g. `bug:triage` for `needs-triage`) — collect the overrides so `triage` applies existing labels instead of creating duplicates.

**Section C — Domain docs.** Default to **single-context** — one `CONTEXT.md` + `docs/adr/` at the repo root. This fits almost every repo; write it without asking.

Offer **multi-context** — a root `CONTEXT-MAP.md` pointing to per-context `CONTEXT.md` files — only when exploration found monorepo signals. Then confirm which layout they want.

**Section D — ADR wiki.**

> Explainer: ADRs document significant architectural decisions. Rather than storing them in the source repo (where they clutter PRs, pollute git history, and live under a different lifecycle than code), they live on the forge's wiki. The wiki is cloned into `docs/adr/` during setup — skills read and write ADRs by relative path, never knowing the difference. At end of session, the agent pushes any new or modified ADRs to the wiki remote.

Derive the wiki URL from the forge detected in Section A:

| Forge | Wiki URL pattern |
| --- | --- |
| **GitHub** | `https://github.com/<owner>/<repo>.wiki.git` |
| **Gitea** | `https://<host>/<owner>/<repo>.wiki.git` |
| **GitLab** | `https://gitlab.com/<owner>/<repo>.wiki.git` |

After the forge is confirmed, present the workflow and confirm:

> Explainer: The agent will need to authenticate to push ADR changes to the wiki. This can use the same credentials the forge CLI (`gh` / `tea`) already stores, or a dedicated token. On every session start, `docs/adr/` is pulled to catch any web UI edits. At end of session, new/modified ADRs are committed and pushed with `git pull --rebase` to handle concurrent edits.

- **Wiki clone bootstrap** — yes, clone into `docs/adr/` and add `docs/adr/` to `.gitignore`. (Always yes for wiki-based ADRs.)
- **Auth method** — from forge CLI (`gh` / `tea`) / SSH key / dedicated token (default: forge CLI)
- **Commit message convention** — `docs(adr): <action> ADR-NNNN — <short description>` (user can customise)

Record the answers in `docs/agents/adr-wiki.md`.

### 3. Confirm and edit

Show the user a draft of:

- The `## Agent skills` block to add to whichever of `CLAUDE.md` / `AGENTS.md` is being edited (see step 4 for selection rules)
- The contents of `docs/agents/issue-tracker.md`, `docs/agents/domain.md`, `docs/agents/adr-wiki.md` and `docs/agents/triage-labels.md` (the last only when `triage` is installed)

Let them edit before writing.

### 4. Write

**Pick the file to edit:**

- If `CLAUDE.md` exists, edit it.
- Else if `AGENTS.md` exists, edit it.
- If neither exists, ask the user which one to create — don't pick for them.

Never create `AGENTS.md` when `CLAUDE.md` already exists (or vice versa) — always edit the one that's already there.

If an `## Agent skills` block already exists in the chosen file, update its contents in-place rather than appending a duplicate. Don't overwrite user edits to the surrounding sections.

The block:

```markdown
## Agent skills

### Issue tracker

[one-line summary of where issues are tracked]. See `docs/agents/issue-tracker.md`.

### Triage labels

[one-line summary of the label vocabulary]. See `docs/agents/triage-labels.md`.

### Domain docs

[one-line summary of layout — "single-context" or "multi-context"]. See `docs/agents/domain.md`.

### ADR wiki

[one-line summary — forge, wiki URL, auth method]. See `docs/agents/adr-wiki.md`.

 ## Project Context Pack

[Agent memory file that describes the repo's context, codebase, and navigation rules]. See `.agents/project-context.md`.

```

Then write the docs files:

- [issue-tracker-github.md](./issue-tracker-github.md) — GitHub issue tracker, including wayfinding operations
- [issue-tracker-gitlab.md](./issue-tracker-gitlab.md) — GitLab issue tracker, including wayfinding operations
- [issue-tracker-gitea.md](./issue-tracker-gitea.md) — Gitea issue tracker, including wayfinding operations
- [triage-labels.md](./triage-labels.md) — label mapping
- [domain.md](./domain.md) — domain doc consumer rules + layout
- [adr-wiki.md](./adr-wiki.md) — ADR wiki clone and push workflow

For GitHub, GitLab, and Gitea, the generated `docs/agents/issue-tracker.md` must include the full "Wayfinding operations" section from the selected template. Do not omit that section when composing the project file.

For "other" issue trackers, write `docs/agents/issue-tracker.md` from scratch using the user's description, and include an equivalent wayfinding section only if the user described a workable wayfinding workflow for that tracker.

### 5. Done

Tell the user the setup is complete, which engineering skills will now read from these files, and that ADR changes are pushed to the forge wiki at end of session. Mention they can edit `docs/agents/*.md` directly later — re-running this skill is only necessary if they want to switch issue trackers, restart from scratch, or reconfigure the ADR wiki or agent CLI.
