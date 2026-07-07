---
id: pkm-curation-vault-conventions
aliases:
  - PKM Curation Vault Conventions
tags:
  - knowledge-management
  - obsidian
  - reference
  - okf
  - ai
area: Personal Knowledge Management
project:
---

# Vault Conventions

This vault follows the [Open Knowledge Format (OKF) v0.1](https://github.com/GoogleCloudPlatform/knowledge-catalog/blob/main/okf/SPEC.md) as its structural backbone. All notes, bundles, and links conform to OKF conventions unless noted below.

---

## Frontmatter Schema (merged — OKF + vault fields)

Every non-reserved `.md` file **MUST** have YAML frontmatter with the following fields:

```yaml
---
type: <OKF type name>              # OKF required
title: <display name>              # OKF recommended
description: <one-line summary>    # OKF recommended
resource: <canonical URI>          # OKF recommended (when applicable)
tags: [<tag>, ...]                 # OKF recommended + vault required
timestamp: <ISO 8601 datetime>     # OKF recommended
id: <unique identifier>            # vault required
aliases: [<alias>, ...]            # vault required
area: <area/domain>                # vault required
project: <project name or ''>      # vault required
---
```

### Field Notes

- **`type`** — Must be one of the OKF type names from the Type Vocabulary table below. This is the **only** required OKF field.
- **`title`** — Human-readable display name. If omitted, consumers may derive a title from the filename.
- **`description`** — One-line summary. Used by index.md generators, search snippets, and previews.
- **`resource`** — A URI identifying the underlying asset the concept describes. Omit for abstract ideas.
- **`tags`** — YAML list of short strings for cross-cutting categorization. Always include at least one tag.
- **`timestamp`** — ISO 8601 datetime of last meaningful change (e.g. `2026-07-06T12:00:00Z`).
- **`id`** — Stable unique identifier (kebab-case slug, never changes).
- **`aliases`** — List of alternative titles for search/discovery.
- **`area`** — Primary domain or area of knowledge.
- **`project`** — Associated project name, or empty string `''` when none.

**OKF extensions:** Any additional producer-defined keys may be included. Consumers MUST preserve unknown keys when round-tripping.

---

## Link Convention

Use **standard markdown links**: `[text](relative/path.md)`.

Do NOT use `[[wikilinks]]`. Obsidian renders standard markdown links identically to wikilinks, and markdown links are portable across all markdown renderers.

### Link Forms

| Target | Markdown form |
|--------|---------------|
| Another note in same directory | `[Note Title](Note%20Title.md)` |
| Note in subdirectory | `[Note Title](../Subdir/Note%20Title.md)` |
| Note with alias | `[alias](Note%20Title.md)` |
| Absolute (bundle-relative) | `[Note Title](/path/from/bundle/root.md)` |
| External URL | `[text](https://example.org)` |

### When to Link

Add links only when they express a real relationship:
- concept to broader concept
- source note to extracted idea
- project note to relevant knowledge note
- daily note to work done or ideas learned
- sibling concepts that genuinely inform one another

Do not link on shared words alone.

---

## Bundle Definition

A **bundle** is a subdirectory that follows OKF progressive-disclosure conventions. Every bundle contains two reserved files:

| File | Purpose |
|------|---------|
| `index.md` | OKF progressive-disclosure listing (no frontmatter, sections with bullet links) |
| `log.md` | OKF chronological update history (datestamped entries, newest first) |

These filenames are **reserved** — they MUST NOT be used for concept documents.

### Bundle root (vault root)

`sjb-brain/` (the vault root) is a bundle. It has its own `index.md` and `log.md`.

### Bundle map

| Path | bundle? |
|------|:-------:|
| `sjb-brain/` (root) | ✅ |
| `Knowledge/` | ✅ |
| `Notes/` + subdirs | ✅ (each subdir is a sub-bundle) |
| `Resources/` + subdirs | ✅ (each subdir is a sub-bundle) |
| `Profiles/` | ✅ |
| `AI Conversation Summaries/` | ✅ |
| `Research/<packet>/` | ✅ (each packet is a bundle) |
| `Projects/<project>/` | ✅ (each project is a bundle, migrate flat notes to dirs) |
| `Inbox/` | ❌ |
| `Dailies/` | ❌ |
| `Templates/` | ❌ |
| `Clippings/` | ❌ |
| `Tasks/`, `tools/`, `wts-services/` | ⏳ deferred |

Non-bundle directories are treated as flat collections. They do not get `index.md` or `log.md`.

---

## Type Vocabulary

The following OKF type names are used in this vault. Every note MUST have exactly one `type` from this table.

| type | Purpose |
|------|---------|
| `Inbox` | Raw capture, unprocessed |
| `Source` | Based on external material |
| `Concept` | One durable evergreen idea |
| `Project` | Active work, planning |
| `Daily` | Day-specific activity |
| `Reference` | Lookup material, specs |
| `Conversation Report` | Narrative summary of conversation |
| `Conversation Transcript` | Raw conversation transcript |
| `Research Synthesis` | Compiled answer for a research topic |
| `Research Claim Index` | Collection of evidence-backed claims |
| `Research Source List` | Index of sources consulted |
| `Research Glossary` | Term definitions for a topic |
| `Research Questions` | Open and resolved questions |
| `Research Log` | Chronological research session log |
| `MOC` | Map of content / curated index |
| `Template` | Template note for note creation |
| `Person` | A person you want notes about |
| `Tool` | A tool, app, or service |

---

## Folder Roles

- `Inbox/`: raw capture and unprocessed notes (not a bundle)
- `Dailies/`: day-specific notes and reflection (not a bundle)
- `Templates/`: note templates (not a bundle)
- `Clippings/`: clipped web articles (not a bundle)
- `Knowledge/`: preferred home for evergreen atomic notes (bundle)
- `Notes/`: technical and domain notes, with subdirectories for each topic (bundle with sub-bundles)
- `Resources/`: reference and resource notes, with subdirectories for each domain (bundle with sub-bundles)
- `Profiles/`: notes about people (bundle)
- `AI Conversation Summaries/`: saved conversation summaries and transcripts (bundle)
- `Research/<packet>/`: research packets, each a self-contained bundle
- `Projects/<project>/`: active project notes, each project a sub-bundle

---

## Task Conventions

- Use Markdown task items: `- [ ] Task description [Project Name](Projects/Project%20Name.md)`
- Add status and priority tags where useful
- Use `due:: YYYY-MM-DD` for due dates
- Add `start::` and `end::` only when explicitly requested or when tracking active work

---

## Curation Heuristics

- A saved thing is not yet a knowledge note.
- A source note is not the same as an evergreen note.
- A link should reflect a real conceptual or project relationship.
- A long note may remain long if it is reference material; only extract notes when reuse is likely.
- Prefer gradual improvement over mass refactoring.
- When creating or editing notes inside a bundle directory, maintain the bundle's `index.md` (add/update entries).
- When a bundle's contents change significantly, append an entry to the bundle's `log.md`.

---

## Core Principles

- Markdown-first
- OKF-conformant bundles with `index.md` and `log.md`
- Standard markdown `[...](...)` links (not wikilinks)
- Atomic notes for durable ideas
- Project, topic, and date-based organization
- Consistency over novelty
