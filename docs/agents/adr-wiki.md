# ADR Wiki

Architecture Decision Records live on the forge wiki and are cloned into `docs/adr/` during setup.

## Wiki URL

```
git@gitea.sagacity.ca:steve/Skills.wiki.git
```

Derived from the forge remote during `/setup-skills`.

## Bootstrap

On first setup, `/setup-skills` clones the wiki:

```bash
git clone git@gitea.sagacity.ca:steve/Skills.wiki.git docs/adr/
```

And adds `docs/adr/` to `.gitignore`.

On subsequent sessions, pull the latest:

```bash
cd docs/adr/ && git pull --rebase
```

## Auth

Authentication for pushing ADR changes uses: **SSH key**

The wiki remote uses `git@gitea.sagacity.ca:steve/Skills.wiki.git` — same SSH key used for the source repo.

## Session-end push

At end of every session, the agent:

1. `cd docs/adr/ && git add -A && git commit -m "docs(adr): <action> ADR-NNNN — <description>"`
2. `git pull --rebase` (handle any web UI edits)
3. `git push`

If a conflict arises during rebase, surface it to the user for resolution.

## Commit message convention

```
docs(adr): add ADR-NNNN — title
docs(adr): update ADR-NNNN — reason
docs(adr): remove ADR-NNNN — superseded by ADR-NNNN
```

## Consumer skills

These skills read from `docs/adr/` by relative path — the wiki clone is transparent:

- `diagnosing-bugs`
- `tdd`
- `improve-codebase-architecture`
- `domain-modeling`
- `grill-with-docs`

These skills may create ADRs in `docs/adr/`; the wiki push is handled at session end:

- `domain-modeling`
- `improve-codebase-architecture`
