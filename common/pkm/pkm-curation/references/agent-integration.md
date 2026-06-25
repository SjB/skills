---
id: pkm-curation-agent-integration
aliases:
  - PKM Curation agent Integration
tags:
  - knowledge-management
  - reference
area: Personal Knowledge Management
project:
---

# Agent Integration

## Purpose

This skill should be usable from any agent, and it should also fit chat environments where the agent as tool access.

## Recommended Role

- batch curation, targeted note cleanup, folder reviews, and repeatable vault maintenance
- interactive note refinement, serendipity review, and exploratory linking sessions
- editor-side entry point that delegates vault actions to agent where possible

## Preferred Behaviors

- search the vault before proposing links
- inspect nearby notes before creating new ones
- patch files directly when the requested change is clear
- summarize edits in plain Markdown
- ask before removing any content or links from a note
- ask before moving, renaming, or creating many files

## Good Task Shapes

- curate a specific note
- process a small `Inbox/` batch
- review recent notes for missing links
- extract atomic notes from one source note
- run a serendipity review against a current topic

## Avoid

- large autonomous folder reorganizations
- broad speculative linking passes
- converting every long note into atomic notes
- changing note titles without stating why

## Portability Guidance

- keep the workflow in `SKILL.md` tool-agnostic where possible
- prefer small deterministic file edits so the skill remains portable to other `SKILL.md`-based agents
