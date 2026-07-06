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

- find out what force is being used for the issue tracker (GitHub, GitLab, or Gitea)
- `AGENTS.md` and `CLAUDE.md`  at the repo root — does either exist? Is there already an ## Agent skills section in either?
* `CONTEXT.md` and `CONTEXT-MAP.md` at the repo root.
- `docs/adr/` (check whether it's a wiki clone via `docs/adr/.git/config`) and any `src/*/docs/adr/` directories
- `docs/agents/` — does this skill's prior output already exist?

### 2. Present findings and ask

Summarise what's present and what's missing. Then walk the user through the five decisions **one at a time** - present a section, get the user's answer, then move to the next. Don't dump all at once.

Assume the user does not know what these terms mean. Each section starts with a short explainer (what it is, why these skills need it, what changes if they pick differently). Then show the choices and the default.

Section A - Issue tracker:

> Explainer: The "issue tracker" is where issues live for this repo. Skills like `to-issues`, `triage`, `to-prd`, and `qa` read from and write to it — they need to know whether to call `gh issue create`, write a markdown file under `.scratch/`, or follow some other workflow you describe. Pick the place you actually track work for this repo.

Default posture: these skills were designed for GitHub. If a `git remote` points at GitHub, propose that. If a `git remote` points at GitLab (`gitlab.com` or a self-hosted host), propose GitLab. If a `git remote` point at a Gitea (a self-hosted host with a `gitea` in the url). Otherwise ask the user, offer:

- **GitHub** — issues live in the repo's GitHub Issues (uses the `gh` CLI)
- **GitLab** — issues live in the repo's GitLab Issues (uses the [`glab`](https://gitlab.com/gitlab-org/cli) CLI)
* Gitea — issues live in the repo's Gitea Issues (uses the `tea` CLI)
- **Other** (Jira, Linear, etc.) — ask the user to describe the workflow in one paragraph; the skill will record it as freeform prose

If — and only if — the user picked **GitHub**, **GitLab** or **Gitea**, ask one follow-up:

> Explainer: Open-source repos often receive feature requests as pull requests, not just issues — a PR is an issue with attached code. If you turn this on, `/triage` pulls *external* PRs into the same queue and runs them through the same labels and states as issues (collaborators' in-flight PRs are left alone). Leave it off if PRs aren't a request surface for you.

- **PRs as a request surface** — yes / no (default: no). Record the answer in `docs/agents/issue-tracker.md`. For local-markdown and other trackers, skip this question — there are no PRs.

**Section B — Triage label vocabulary.**

> Explainer: When the `triage` skill processes an incoming issue, it moves it through a state machine — needs evaluation, waiting on reporter, ready for an AFK agent to pick up, ready for a human, or won't fix. To do that, it needs to apply labels (or the equivalent in your issue tracker) that match strings *you've actually configured*. If your repo already uses different label names (e.g. `bug:triage` instead of `needs-triage`), map them here so the skill applies the right ones instead of creating duplicates.

Look at the `triage-labels.md` file for the labels and each roles they define.

Default: each role's string equals its name. Ask the user if they want to override any. If their issue tracker has no existing labels, the defaults are fine.

**Section C — Domain docs.**

> Explainer: Some skills (`improve-codebase-architecture`, `diagnosing-bugs`, `tdd`) read a `CONTEXT.md` file to learn the project's domain languagee, and `adr` for past architectural decisions. They need to know whether the repo has one global context or multiple (e.g. a monorepo with separate frontend/backend contexts) so they look in the right place.

Confirm the layout:

- **Single-context** — one `CONTEXT.md` + `adr` at the repo root. Most repos are this.
- **Multi-context** — `CONTEXT-MAP.md` at the root pointing to per-context `CONTEXT.md` files (typically a monorepo).

**Section D — ADR wiki.**

> Explainer: ADRs document significant architectural decisions. Rather than storing them in the source repo (where they clutter PRs, pollute git history, and live under a different lifecycle than code), they live on the forge's wiki. The wiki is cloned into `docs/adr/` during setup — skills read and write ADRs by relative path, never knowing the difference. At end of session, the agent pushes any new or modified ADRs to the wiki remote.

Derive the wiki URL from the forge detected in Section A:

| Forge | Wiki URL pattern |
|---|---|
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
- The contents of `docs/agents/issue-tracker.md`, `docs/agents/triage-labels.md`, `docs/agents/domain.md`, `docs/agents/adr-wiki.md`, and `docs/agents/agent-cli.md`

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

[one-line summary of where issues are tracked, plus whether external PRs are a triage surface]. See `docs/agents/issue-tracker.md`.

### Triage labels

[one-line summary of the label vocabulary]. See `docs/agents/triage-labels.md`.

### Domain docs

[one-line summary of layout — "single-context" or "multi-context"]. See `docs/agents/domain.md`.

### ADR wiki

[one-line summary — forge, wiki URL, auth method]. See `docs/agents/adr-wiki.md`.

### Agent CLI

[one-line summary of the configured CLI agent]. See `docs/agents/agent-cli.md`.

 ## Project Context Pack

[Agent memory file that describes the repo's context, codebase, and navigation rules]. See `.agents/project-context.md`.

```

Then write the docs files:

- [issue-tracker-github.md](./issue-tracker-github.md) — GitHub issue tracker
- [issue-tracker-gitlab.md](./issue-tracker-gitlab.md) — GitLab issue tracker
- [issue-tracker-gitea.md](./issue-tracker-gitea.md) — Gitea issue tracker
- [triage-labels.md](./triage-labels.md) — label mapping
- [domain.md](./domain.md) — domain doc consumer rules + layout
- [adr-wiki.md](./adr-wiki.md) — ADR wiki clone and push workflow
- `docs/agents/agent-cli.md` — agent CLI config with `selected`, `binary`, and `args` fields

For "other" issue trackers, write `docs/agents/issue-tracker.md` from scratch using the user's description.

### 5. Done

Tell the user the setup is complete, which engineering skills will now read from these files, and that ADR changes are pushed to the forge wiki at end of session. Mention they can edit `docs/agents/*.md` directly later — re-running this skill is only necessary if they want to switch issue trackers, restart from scratch, or reconfigure the ADR wiki or agent CLI.
