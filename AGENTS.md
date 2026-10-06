# Steve Beaulac Skills

A collection of agent skills (slash commands and behaviors) loaded into AI coding agents. Skills live under `skills/`, grouped by purpose; each bucket README and the root README index its `SKILL.md` files by invocation type.

## Skill buckets

- `engineering/` — daily code work
- `in-progress/` — drafts not yet ready to ship
- `misc/` — kept around but rarely used
- `personal/` — tied to the user's own setup, not promoted
- `pkm/` — personal knowledge management
- `pstack/` — personal agent workflow skills
- `productivity/` — general workflow tools
- `setup-skills/` — one-time repository setup skill and its references
- `skill-authoring/` — create and maintain agent skills
- `thinking-and-docs/` — decisions and documentation workflows

Each bucket folder has a `README.md` that lists every skill in the bucket with a one-line description, with the skill name linked to its `SKILL.md`. Bucket `README.md`s and the top-level `README.md` group entries into **User-invoked** and **Model-invoked**.

Every `SKILL.md` is either user-invoked (`disable-model-invocation: true`, reachable only by the human) or model-invoked (model- or user-reachable). For the full definitions, description conventions, and why a user-invoked skill can invoke model-invoked skills but never another user-invoked one, see [docs/invocation.md](./docs/invocation.md).

## Agent skills

### Issue tracker

Issues are tracked in Gitea on gitea.sagacity.ca. See `docs/agents/issue-tracker.md`.

### Triage labels

Seven-label vocabulary with default names (needs-triage, needs-info, needs-review, ready-for-agent, ready-for-human, in-progress, wontfix). See `docs/agents/triage-labels.md`.

### Domain docs

Single-context layout. See `docs/agents/domain.md`.

### ADR wiki

Gitea wiki at `git@gitea.sagacity.ca:steve/Skills.wiki.git`, cloned into `docs/adr/`, SSH key auth. See `docs/agents/adr-wiki.md`.

## Project Context Pack

Agent memory file that describes the repo's context, codebase, and navigation rules. See `.agent/project-context.md`.

### Agent CLI

`pi` used for child agents. See `docs/agents/agent-cli.md`.
