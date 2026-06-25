---
id: pkm-curation-vault-conventions
aliases:
  - PKM Curation Vault Conventions
tags:
  - knowledge-management
  - obsidian
  - reference
  - ai
area: Personal Knowledge Management
project:
---

# Vault Conventions

## Required Frontmatter

All notes should include YAML frontmatter with:

```yaml
---
id: unique-id
aliases: []
tags: []
area: Primary area/domain
project: [[Project Note]]
---
```

Use an empty value for `project:` when there is no relevant project note.

## Core Principles

- Markdown-first
- explicit `[[wikilinks]]`
- atomic notes for durable ideas
- project, topic, and date-based organization
- consistency over novelty

## Folder Roles

- `Inbox/`: raw capture and unprocessed notes
- `Dailies/`: day-specific notes and reflection
- `Templates/`: note templates
- `Knowledge/`: preferred home for evergreen atomic notes if the folder exists or is created
- project/topic folders: active work and structured reference material

## Task Conventions

- Use Markdown task items: `- [ ] Task description [[Project Name]]`
- Add status and priority tags where useful
- Use `due:: YYYY-MM-DD` for due dates
- Add `start::` and `end::` only when explicitly requested or when tracking active work

## Curation Heuristics

- A saved thing is not yet a knowledge note.
- A source note is not the same as an evergreen note.
- A link should reflect a real conceptual or project relationship.
- A long note may remain long if it is reference material; only extract notes when reuse is likely.
- Prefer gradual improvement over mass refactoring.
