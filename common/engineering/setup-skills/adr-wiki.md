# ADR Wiki

Architecture Decision Records live on the forge wiki and are cloned into `docs/adr/` during setup.

## Wiki URL

```
<wiki-url>
```

Derived from the forge remote during `/setup-matt-pocock-skills`.

## Bootstrap

On first setup, `/setup-matt-pocock-skills` clones the wiki:

```bash
git clone <wiki-url> docs/adr/
```

And adds `docs/adr/` to `.gitignore`.

On subsequent sessions, pull the latest:

```bash
cd docs/adr/ && git pull --rebase
```

## Auth

Authentication for pushing ADR changes uses: `<auth-method>`

- **Forge CLI token** — `gh` or `tea` already stores credentials; use them for git push via HTTPS with token auth.
- **SSH key** — wiki remote uses `git@<host>:<owner>/<repo>.wiki.git`.
- **Dedicated token** — stored in env var `GIT_WIKI_TOKEN`; used as password in HTTPS URL.

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
