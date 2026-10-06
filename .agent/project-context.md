# Project Context Pack

## Purpose

Repository of agent skills: each skill is a folder with a `SKILL.md` plus optional references, scripts, or assets.

## Structure

- `skills/` — skills grouped by category; each bucket has a README index.
- `skills/setup-skills/` — one-time repo configuration skill and its supporting guides.
- `README.md` — complete index of skills by invocation type and category.
- `AGENTS.md` — repository conventions and pointers to agent documentation.
- `docs/invocation.md` — user-invoked vs model-invoked behavior.
- `docs/agents/` — issue tracker, triage labels, ADR wiki, and domain-document conventions.
- `docs/engineering/` — reusable engineering process references.
- `docs/adr/` — ADR wiki clone; gitignored.
- `.agent/project-context.md` — this context pack.

## Skill categories

`engineering`, `in-progress`, `misc`, `personal`, `pkm`, `pstack`, `productivity`, `setup-skills`, `skill-authoring`, and `thinking-and-docs`.

## Conventions

- Skills are user-invoked when frontmatter sets `disable-model-invocation: true`; otherwise they are model-invoked.
- Keep root and bucket README indexes synchronized with `SKILL.md` frontmatter and file paths.
- Read `docs/invocation.md` for invocation rules; read the relevant `docs/agents/` guide for tracker, triage, ADR, or domain-doc work.
- Source files in this repository are authoritative; global installed copies are separate.

## Validation

There is no build or test suite. For index changes, verify every `SKILL.md` appears once in the root index and its category index, links resolve, and invocation grouping matches frontmatter.
