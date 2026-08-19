---
id: pkm-curation-agent-integration
aliases:
  - PKM Curation agent Integration
tags:
  - knowledge-management
  - reference
  - okf
area: Personal Knowledge Management
project: ''
---

# Agent Integration

## Purpose

This skill should be usable from any agent, and it should also fit chat environments where the agent has tool access.

## Recommended Role

- batch curation, targeted note cleanup, folder reviews, and repeatable vault maintenance
- interactive note refinement, serendipity review, and exploratory linking sessions
- editor-side entry point that delegates vault actions to agent where possible

## Bundle Awareness

The vault follows OKF v0.1 bundle conventions. When running curation tasks:

- Creating a note inside a bundle directory: add an entry to `index.md` and an event to `log.md`.
- Modifying a note inside a bundle: update `index.md` description if the note's purpose changes; append to `log.md` for significant changes.
- Moving notes between bundle directories: update both source and destination bundle files.

## Preferred Behaviors

- search the vault before proposing links
- inspect nearby notes before creating new ones
- patch files directly when the requested change is clear
- summarize edits in plain Markdown
- ask before removing any content or links from a note
- ask before moving, renaming, or creating many files
- update bundle `index.md` and `log.md` when creating notes inside bundles

## Good Task Shapes

- curate a specific note (normalize frontmatter, classify type, add markdown links)
- process a small `Inbox/` batch (classify and normalize)
- review recent notes for missing links
- extract atomic notes from one source note
- run a serendipity review against a current topic
- update or regenerate bundle `index.md` for a directory

## Avoid

- large autonomous folder reorganizations
- broad speculative linking passes
- converting every long note into atomic notes
- changing note titles without stating why
- using `[[wikilinks]]` — always use standard markdown `[...](...)` links

## Portability Guidance

- keep the workflow in `SKILL.md` tool-agnostic where possible
- prefer small deterministic file edits so the skill remains portable to other `SKILL.md`-based agents
- always reference `vault-conventions.md` for the current frontmatter schema and type vocabulary
