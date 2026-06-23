---
name: knowledge-gardener
description: Run vault-aware semantic search, synthesis, note creation, linking, and Zettelkasten workflows for this Obsidian vault.
metadata:
  vault_style: para-plus-zettelkasten
  default_write_folder: Inbox
  daily_folder: Dailies
  templates_folder: Templates
disable-model-invocation: true
---

## Purpose

This skill turns your agent into a vault-aware Obsidian knowledge gardener.
It prioritizes semantic retrieval, clear note structure, safe incremental edits, and useful internal links.

## Vault Conventions

- Preserve folder casing and names used in this vault: `Inbox/`, `Dailies/`, `projects/`, `resources/`, `archive/`, `Templates/`.
- Use Obsidian wikilinks: `[[Note Title]]`.
- Keep existing frontmatter schema compatible with existing notes:

```yaml
---
id: <slug-or-date-id>
aliases: []
tags: []
area: ""
project: ""
---
```

- Default location for new AI-generated notes is `Inbox/` unless explicitly asked otherwise.

## Core Workflows

1. Semantic Search
   - Use `python tools/obsidian_semantic_query.py --vault-root . --query "..." --k 12`.
   - Return ranked notes with short relevance rationale.

2. Summarization
   - Retrieve nearest notes first, then synthesize.
   - Include conflicts, unknowns, and suggested next notes.

3. New Note Creation
   - Create with canonical frontmatter.
   - Include `## Summary` and optional scaffold sections.
   - If a summary is provided, include it verbatim under `## Summary`.

4. Automatic Linking
   - Suggest links from semantically related notes.
   - Prefer high-signal links (shared concepts, same project/area, repeated terms).

5. Refactor to Atomic Notes
   - Split long mixed-topic notes into smaller notes.
   - Keep parent note as a structure note and link to children.

6. Metadata Maintenance
   - Keep `id`, `aliases`, `tags`, `area`, `project` valid.
   - Suggest tags from note content; avoid noisy tag spam.

7. Research Capture
   - Store source summary in vault.
   - Extract key claims, evidence, and follow-up questions.
   - Convert durable insights into permanent notes.

8. Zettelkasten Conversion
   - Convert source note into atomic permanent notes.
   - Add explicit links and one short structure note (MOC-lite) when useful.

## Quality Guardrails

- Never delete user content unless explicitly requested.
- Prefer additive edits and clear section boundaries.
- Keep writing concise and skimmable.
- Keep tags focused and reusable.
- Rebuild semantic index after major note creation/refactor sessions.

## Operational Commands

- Build index: `python tools/obsidian_semantic_index.py --vault-root .`
- Query index: `python tools/obsidian_semantic_query.py --vault-root . --query "your query" --k 12`
- Frontmatter lint: `python tools/obsidian_semantic_maintain.py lint --vault-root .`
- Related notes: `python tools/obsidian_semantic_maintain.py related --vault-root . --note "Inbox/your-note.md" --k 8`

## Trigger Hints

Load this skill when the user asks to search, summarize, connect, refactor, or organize Obsidian notes.
