# Domain Docs

How the engineering skills should consume this repo's domain documentation when exploring the codebase.

## Before exploring, read these

- **`CONTEXT.md`** at the repo root, or
- **`CONTEXT-MAP.md`** at the repo root if it exists — it points at one `CONTEXT.md` per context. Read each one relevant to the topic.
- **`docs/adr/`** — read ADRs that touch the area you're about to work in. In multi-context repos, also check `/doc/adr/<context>/` for context-scoped decisions.

If any of these files don't exist, **proceed silently**. Don't flag their absence; don't suggest creating them upfront. The `/domain-modeling` skill (reached via `/grill-with-docs` and `/improve-codebase-architecture`) creates them lazily when terms or decisions actually get resolved.

## File structure

Single-context repo (most repos):

```
/
├── CONTEXT.md
├── docs/adr/
│   ├── 0001-event-sourced-orders.md
│   └── 0002-postgres-for-write-model.md
├── src/
└── .gitignore                     ← docs/adr/ ignored
```

Multi-context repo (presence of `CONTEXT-MAP.md` at the root):

```
/
├── CONTEXT-MAP.md
├── src/
├── .gitignore                         ← docs/adr/ ignored
└── docs/adr/                          ← system-wide decisions
    ├── ordering/                      ← context scope decisions
    │   ├── CONTEXT.md
    │   └── 0001-event-source-orders.md
    └── billing/                       ← context scope decisions
        ├── CONTEXT.md
        └── 0002-postgres-for-write-model.md
```


## ADR lifecycle

ADRs live on the forge wiki and are cloned into `docs/adr/` during setup (`/setup-matt-pocock-skills`). The source repo ignores `docs/adr/` via `.gitignore`.

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

## ADR storage

ADR documents are stored in a clone repo of the forge wiki, if the `docs/adr` folder does not exist ask the user for the repo url and clone it. Commit each changes without asking the user for a commit message and push to the remote. 
