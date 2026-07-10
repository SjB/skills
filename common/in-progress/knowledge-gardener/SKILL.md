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
   - Extract key claims, evidence, confidence, and follow-up questions.
   - Distinguish raw source claims, agent synthesis, user opinions, and open questions.
   - Convert durable insights into permanent notes.

8. Compiled Wiki Maintenance
   - For bounded research topics, maintain a Karpathy-style compiled wiki layer: immutable raw sources → maintained concept/claim/synthesis notes → retrievable answers.
   - On ingest, update existing pages before creating duplicates; the graph should get denser, not just larger.
   - File durable query answers back into notes, then add or update links from indexes/MOCs.
   - Keep a lightweight log of ingests, filed answers, lint passes, promotions, and major corrections when the folder has a `Log.md` or equivalent.

9. Retrieval Lint
   - Check for unsupported claims, stale or contradictory claims, orphan notes, missing backlinks, missing glossary terms, and unanswered questions.
   - Verify a future agent can answer the main question from the maintained notes without rereading raw sources.

10. Packet Promotion
   - Treat research packets as incubators and the main vault as the indexed library.
   - Promote notes only when they are reusable beyond the packet, stand alone, have evidence/provenance, and connect to existing vault concepts.
   - Leave a link behind in the packet and update relevant indexes/MOCs.

11. Zettelkasten Conversion
   - Convert source note into atomic permanent notes.
   - Add explicit links and one short structure note (MOC-lite) when useful.

## Quality Guardrails

- Never delete user content unless explicitly requested.
- Prefer additive edits and clear section boundaries.
- Keep writing concise and skimmable.
- Keep tags focused and reusable.
- Keep citations close to claims; do not let synthesized notes obscure source provenance.
- Before finalizing research edits, run a retrieval check: likely future questions should have obvious entry points through indexes, links, claims, or glossary terms.
- Rebuild semantic index after major note creation/refactor sessions.

## Operational Commands

- Build index: `python tools/obsidian_semantic_index.py --vault-root .`
- Query index: `python tools/obsidian_semantic_query.py --vault-root . --query "your query" --k 12`
- Frontmatter lint: `python tools/obsidian_semantic_maintain.py lint --vault-root .`
- Related notes: `python tools/obsidian_semantic_maintain.py related --vault-root . --note "Inbox/your-note.md" --k 8`

## Trigger Hints

Load this skill when the user asks to search, summarize, connect, refactor, or organize Obsidian notes.
