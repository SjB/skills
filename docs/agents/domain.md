# Domain Docs

How the engineering skills should consume this repo's domain documentation when exploring the codebase.

## Before exploring, read these

- **`CONTEXT.md`** at the repo root, or
- **`CONTEXT-MAP.md`** at the repo root if it exists — it points at one `CONTEXT.md` per context. Read each one relevant to the topic.
- **`docs/adr/`** — read ADRs that touch the area you're about to work in.

If any of these files don't exist, **proceed silently**. Don't flag their absence; don't suggest creating them upfront. The `/domain-modeling` skill creates them lazily when terms or decisions actually get resolved.

## File structure

**Single-context repo** (this repo):

```
/
├── CONTEXT.md
├── docs/adr/
│   ├── 0001-event-sourced-orders.md
│   └── 0002-postgres-for-write-model.md
├── src/
└── .gitignore                     ← docs/adr/ ignored
```

## ADR lifecycle

ADRs live on the forge wiki and are cloned into `docs/adr/` during setup (`/setup-skills`). The source repo ignores `docs/adr/` via `.gitignore`.

- **Reading** — skills read ADRs by relative path (`docs/adr/...`) as before. The wiki clone is transparent.
- **Creating / updating** — skills write ADRs to `docs/adr/` as files. Changes accumulate in the wiki clone's local git state.
- **Pushing** — at end of session, the agent commits new/modified ADRs to the wiki clone and pushes to the forge wiki remote, using `git pull --rebase` before push to handle any concurrent web edits.
- **Commit message convention**: `docs(adr): <action> ADR-NNNN — <short description>`

## Use the glossary's vocabulary

When your output names a domain concept (in an issue title, a refactor proposal, a hypothesis, a test name), use the term as defined in `CONTEXT.md`. Don't drift to synonyms the glossary explicitly avoids.

If the concept you need isn't in the glossary yet, that's a signal — either you're inventing language the project doesn't use (reconsider) or there's a real gap (note it for `/domain-modeling`).

## Flag ADR conflicts

If your output contradicts an existing ADR, surface it explicitly rather than silently overriding:

> _Contradicts ADR-0007 (event-sourced orders) — but worth reopening because…_
